import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

enum AppMessageType { info, success, warning, error }

/// Places application messages above the navigator so route and dialog
/// transitions cannot absorb taps intended for the close button.
class AppMessageHost extends StatefulWidget {
  const AppMessageHost({required this.child, super.key});

  final Widget child;

  @override
  State<AppMessageHost> createState() => _AppMessageHostState();
}

class _AppMessageHostState extends State<AppMessageHost> {
  late final OverlayEntry _content = OverlayEntry(
    builder: (context) => widget.child,
  );

  @override
  void didUpdateWidget(covariant AppMessageHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    _content.markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) =>
      Overlay(initialEntries: <OverlayEntry>[_content]);
}

abstract final class AppMessage {
  static final Queue<_MessageRequest> _queue = Queue<_MessageRequest>();
  static OverlayEntry? _currentEntry;
  static _MessageRequest? _currentRequest;

  static void show(
    BuildContext context,
    String message, {
    AppMessageType type = AppMessageType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null || message.trim().isEmpty) return;
    final currentOverlay = _currentRequest?.overlay;
    if (_currentEntry != null && !identical(currentOverlay, overlay)) {
      _currentEntry = null;
      _currentRequest = null;
      _queue.clear();
    }
    final normalizedMessage = message.trim();
    final currentRequest = _currentRequest;
    final duplicateCurrent =
        currentRequest != null &&
        currentRequest.message == normalizedMessage &&
        currentRequest.type == type;
    final duplicatePending = _queue.any(
      (request) => request.message == normalizedMessage && request.type == type,
    );
    if (duplicateCurrent || duplicatePending) return;
    _queue.add(
      _MessageRequest(
        overlay: overlay,
        message: normalizedMessage,
        type: type,
        duration: duration,
      ),
    );
    _showNext();
  }

  static void _showNext() {
    if (_currentEntry != null || _queue.isEmpty) return;
    final request = _queue.removeFirst();
    if (!request.overlay.mounted) {
      scheduleMicrotask(_showNext);
      return;
    }
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _TopMessage(
        message: request.message,
        type: request.type,
        duration: request.duration,
        onTimeout: () => _dismiss(entry),
        onClose: () => _dismiss(entry, clearPending: true),
      ),
    );
    _currentEntry = entry;
    _currentRequest = request;
    request.overlay.insert(entry);
  }

  static void _dismiss(OverlayEntry entry, {bool clearPending = false}) {
    if (!identical(_currentEntry, entry)) return;
    _currentEntry = null;
    _currentRequest = null;
    if (clearPending) _queue.clear();
    if (entry.mounted) entry.remove();
    if (!clearPending) scheduleMicrotask(_showNext);
  }
}

final class _MessageRequest {
  const _MessageRequest({
    required this.overlay,
    required this.message,
    required this.type,
    required this.duration,
  });

  final OverlayState overlay;
  final String message;
  final AppMessageType type;
  final Duration duration;
}

class _TopMessage extends StatefulWidget {
  const _TopMessage({
    required this.message,
    required this.type,
    required this.duration,
    required this.onTimeout,
    required this.onClose,
  });

  final String message;
  final AppMessageType type;
  final Duration duration;
  final VoidCallback onTimeout;
  final VoidCallback onClose;

  @override
  State<_TopMessage> createState() => _TopMessageState();
}

class _TopMessageState extends State<_TopMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lifetime;

  @override
  void initState() {
    super.initState();
    _lifetime = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          scheduleMicrotask(widget.onTimeout);
        }
      });
    unawaited(_lifetime.forward());
  }

  @override
  void dispose() {
    _lifetime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final (background, foreground, icon) = switch (widget.type) {
      AppMessageType.info => (
        colors.inverseSurface,
        colors.onInverseSurface,
        Icons.info_outline,
      ),
      AppMessageType.success => (
        colors.primaryContainer,
        colors.onPrimaryContainer,
        Icons.check_circle_outline,
      ),
      AppMessageType.warning => (
        colors.tertiaryContainer,
        colors.onTertiaryContainer,
        Icons.warning_amber_outlined,
      ),
      AppMessageType.error => (
        colors.errorContainer,
        colors.onErrorContainer,
        Icons.error_outline,
      ),
    };
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: AnimatedBuilder(
          animation: _lifetime,
          builder: (context, child) {
            final elapsedMilliseconds =
                _lifetime.value * widget.duration.inMilliseconds;
            final entrance = Curves.easeOut.transform(
              (elapsedMilliseconds / 180).clamp(0.0, 1.0),
            );
            return Opacity(
              opacity: entrance,
              child: Transform.translate(
                offset: Offset(0, -16 * (1 - entrance)),
                child: child,
              ),
            );
          },
          child: Semantics(
            liveRegion: true,
            container: true,
            child: Material(
              color: background,
              elevation: 8,
              shadowColor: colors.shadow,
              borderRadius: BorderRadius.circular(14),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 14,
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(icon, color: foreground),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: foreground),
                      ),
                    ),
                    IconButton(
                      tooltip: MaterialLocalizations.of(
                        context,
                      ).closeButtonTooltip,
                      onPressed: widget.onClose,
                      color: foreground,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
