const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');
const { once } = require('events');
const sharp = require('sharp');
const ffmpegPath = require('ffmpeg-static');

const WIDTH = 1080;
const HEIGHT = 1920;
const FPS = 30;
const DURATION = 27;
const TOTAL_FRAMES = FPS * DURATION;
const ROOT = path.resolve(__dirname, '..');
const OUTPUT = path.join(ROOT, 'banxin-promo-vertical.mp4');
const COVER = path.join(ROOT, 'promo-video-cover.png');
const AUDIO = path.join(__dirname, 'promo-music.wav');

const COLORS = {
  ink: '#171A2C',
  muted: '#73788D',
  primary: '#5965E8',
  primary2: '#7A5CE6',
  green: '#2BAA7F',
  orange: '#F0A43C',
  white: '#FFFFFF',
};

const screens = {
  home: path.join(ROOT, 'prototype-home-mobile.png'),
  calendar: path.join(ROOT, 'prototype-calendar-mobile.png'),
  stats: path.join(ROOT, 'prototype-stats-mobile.png'),
  ai: path.join(ROOT, 'prototype-ai-assistant-mobile.png'),
};

function clamp(v, min = 0, max = 1) {
  return Math.max(min, Math.min(max, v));
}

function lerp(a, b, t) {
  return a + (b - a) * t;
}

function easeOutCubic(t) {
  t = clamp(t);
  return 1 - Math.pow(1 - t, 3);
}

function easeInOutCubic(t) {
  t = clamp(t);
  return t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2;
}

function easeOutBack(t) {
  t = clamp(t);
  const c1 = 1.70158;
  const c3 = c1 + 1;
  return 1 + c3 * Math.pow(t - 1, 3) + c1 * Math.pow(t - 1, 2);
}

function esc(value) {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function svgText(text, x, y, size, options = {}) {
  const {
    fill = COLORS.ink,
    weight = 700,
    anchor = 'start',
    opacity = 1,
    letterSpacing = 0,
  } = options;
  return `<text x="${x}" y="${y}" fill="${fill}" font-size="${size}" font-weight="${weight}"
    text-anchor="${anchor}" opacity="${opacity}" letter-spacing="${letterSpacing}"
    font-family="Microsoft YaHei, PingFang SC, Noto Sans CJK SC, sans-serif">${esc(text)}</text>`;
}

function pill(text, x, y, width, fill, color, opacity = 1) {
  return `<g opacity="${opacity}">
    <rect x="${x}" y="${y}" width="${width}" height="54" rx="27" fill="${fill}"/>
    ${svgText(text, x + width / 2, y + 36, 24, { fill: color, weight: 700, anchor: 'middle' })}
  </g>`;
}

function logoMark(x, y, size, opacity = 1) {
  const r = size * 0.29;
  return `<g opacity="${opacity}" transform="translate(${x} ${y})">
    <defs>
      <linearGradient id="logoGradient" x1="0" y1="0" x2="1" y2="1">
        <stop offset="0" stop-color="#6C77F0"/>
        <stop offset="1" stop-color="#7758D8"/>
      </linearGradient>
    </defs>
    <rect width="${size}" height="${size}" rx="${r}" fill="url(#logoGradient)"/>
    <rect x="${size * .22}" y="${size * .25}" width="${size * .56}" height="${size * .50}" rx="${size * .09}"
      fill="none" stroke="white" stroke-width="${size * .055}"/>
    <path d="M ${size * .22} ${size * .39} H ${size * .78}" stroke="white" stroke-width="${size * .055}"/>
    <circle cx="${size * .39}" cy="${size * .55}" r="${size * .055}" fill="white"/>
    <path d="M ${size * .56} ${size * .53} l ${size * .06} ${size * .06} l ${size * .12} -${size * .14}"
      fill="none" stroke="#A8F0D4" stroke-width="${size * .055}" stroke-linecap="round" stroke-linejoin="round"/>
  </g>`;
}

function backgroundSvg(time, tint = 'purple') {
  const palette = tint === 'green'
    ? ['#F2FBF8', '#EDF2FF', '#E6F8F1']
    : tint === 'orange'
      ? ['#FFF8EE', '#F1F2FF', '#FFF0D8']
      : ['#F0F1FF', '#F8F8FC', '#ECEBFF'];
  const drift = Math.sin(time * 0.8) * 25;
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${WIDTH}" height="${HEIGHT}">
    <defs>
      <radialGradient id="bgA" cx="20%" cy="10%" r="70%">
        <stop offset="0" stop-color="${palette[0]}"/><stop offset="1" stop-color="${palette[1]}"/>
      </radialGradient>
      <radialGradient id="orbA"><stop offset="0" stop-color="#7D87F4" stop-opacity=".28"/><stop offset="1" stop-color="#7D87F4" stop-opacity="0"/></radialGradient>
      <radialGradient id="orbB"><stop offset="0" stop-color="#48C59B" stop-opacity=".20"/><stop offset="1" stop-color="#48C59B" stop-opacity="0"/></radialGradient>
    </defs>
    <rect width="1080" height="1920" fill="url(#bgA)"/>
    <circle cx="${145 + drift}" cy="250" r="310" fill="url(#orbA)"/>
    <circle cx="${975 - drift}" cy="1510" r="390" fill="url(#orbB)"/>
    <g opacity=".16" fill="none" stroke="#7E84A5" stroke-width="1">
      <path d="M60 1510 H1020 M60 1570 H1020 M60 1630 H1020 M60 1690 H1020"/>
      <path d="M110 1455 V1740 M230 1455 V1740 M350 1455 V1740 M470 1455 V1740 M590 1455 V1740 M710 1455 V1740 M830 1455 V1740 M950 1455 V1740"/>
    </g>
  </svg>`;
}

async function createPhoneAsset(screenPath) {
  const screenW = 690;
  const screenH = 1492;
  const roundedMask = Buffer.from(`<svg width="${screenW}" height="${screenH}" xmlns="http://www.w3.org/2000/svg"><rect width="${screenW}" height="${screenH}" rx="49" fill="white"/></svg>`);
  const screenshot = await sharp(screenPath)
    .resize(screenW, screenH, { fit: 'cover' })
    .composite([{ input: roundedMask, blend: 'dest-in' }])
    .png()
    .toBuffer();
  const frameSvg = Buffer.from(`<svg width="730" height="1532" xmlns="http://www.w3.org/2000/svg">
    <defs><linearGradient id="f" x1="0" y1="0" x2="1" y2="1"><stop stop-color="#12131A"/><stop offset="1" stop-color="#292B38"/></linearGradient></defs>
    <rect width="730" height="1532" rx="66" fill="url(#f)"/>
    <rect x="10" y="10" width="710" height="1512" rx="58" fill="#090A0E" opacity=".75"/>
  </svg>`);
  return sharp({ create: { width: 730, height: 1532, channels: 4, background: { r: 0, g: 0, b: 0, alpha: 0 } } })
    .composite([
      { input: frameSvg, left: 0, top: 0 },
      { input: screenshot, left: 20, top: 20 },
    ])
    .png()
    .toBuffer();
}

function sceneInfo(t) {
  if (t < 3) return { name: 'hook', start: 0, end: 3 };
  if (t < 7) return { name: 'calendar', start: 3, end: 7 };
  if (t < 11) return { name: 'alarm', start: 7, end: 11 };
  if (t < 15) return { name: 'stats', start: 11, end: 15 };
  if (t < 20.5) return { name: 'ai', start: 15, end: 20.5 };
  if (t < 23.5) return { name: 'action', start: 20.5, end: 23.5 };
  return { name: 'end', start: 23.5, end: 27 };
}

function scenePhoneName(scene) {
  return ({ calendar: 'calendar', alarm: 'home', stats: 'stats', ai: 'ai', action: 'ai' })[scene];
}

function sectionHeading(index, eyebrow, title1, title2, subtitle, progress) {
  const enter = easeOutCubic(progress * 4.2);
  const y = lerp(250, 152, enter);
  return `<g opacity="${enter}">
    ${pill(`${index} · ${eyebrow}`, 82, y - 61, 260, '#FFFFFF', COLORS.primary)}
    ${svgText(title1, 82, y + 60, 62, { weight: 850 })}
    ${svgText(title2, 82, y + 132, 62, { weight: 850, fill: COLORS.primary })}
    ${svgText(subtitle, 82, y + 186, 28, { fill: COLORS.muted, weight: 550 })}
  </g>`;
}

function foregroundSvg(scene, t, progress) {
  let markup = '';
  if (scene === 'hook') {
    const e = easeOutBack(progress * 2.6);
    const fade = clamp((1 - progress) * 4);
    const logoY = lerp(520, 390, e);
    markup += `<g opacity="${fade}">
      ${logoMark(440, logoY, 200, e)}
      ${svgText('班薪日历', 540, logoY + 295, 86, { anchor: 'middle', weight: 900, opacity: e })}
      ${svgText('班次清楚，工资有数。', 540, logoY + 380, 42, { anchor: 'middle', weight: 650, fill: COLORS.primary, opacity: e })}
      ${svgText('排班 · 闹钟 · 工时 · 工资 · AI 助理', 540, logoY + 448, 28, { anchor: 'middle', weight: 550, fill: COLORS.muted, opacity: e })}
      ${pill('单双休', 165, 1240, 170, '#FFFFFF', '#555C77', e)}
      ${pill('大小周', 355, 1240, 170, '#FFFFFF', '#555C77', e)}
      ${pill('调休', 545, 1240, 150, '#FFFFFF', '#555C77', e)}
      ${pill('工资统计', 715, 1240, 200, '#FFFFFF', '#555C77', e)}
    </g>`;
  } else if (scene === 'calendar') {
    markup += sectionHeading('01', '智能排班', '单双休、大小周', '一眼看懂', '节假日与调休自动标记', progress);
  } else if (scene === 'alarm') {
    markup += sectionHeading('02', '智能闹钟', '班次一改', '闹钟跟着改', '上班准时响，休息不打扰', progress);
    const p = easeOutBack(clamp((progress - .45) * 4));
    markup += `<g opacity="${p}" transform="translate(${lerp(980, 755, p)} 1210)">
      <rect width="245" height="128" rx="30" fill="#202337"/>
      ${svgText('下个闹钟', 24, 38, 22, { fill: '#AEB4CF', weight: 600 })}
      ${svgText('07:10', 24, 91, 42, { fill: 'white', weight: 850 })}
      <circle cx="205" cy="36" r="10" fill="#43C69B"/>
    </g>`;
  } else if (scene === 'stats') {
    markup += sectionHeading('03', '工时工资', '出勤多久', '收入多少', '自动统计，每一笔都能核对', progress);
    const p = easeOutBack(clamp((progress - .48) * 4));
    markup += `<g opacity="${p}" transform="translate(80 ${lerp(1700, 1440, p)})">
      <rect width="920" height="190" rx="38" fill="#202337"/>
      ${svgText('本月预计工资', 42, 55, 24, { fill: '#AEB4CF', weight: 600 })}
      ${svgText('¥ 6,842.50', 42, 126, 52, { fill: 'white', weight: 850 })}
      <rect x="690" y="47" width="182" height="66" rx="20" fill="#2DAD83" opacity=".18"/>
      ${svgText('加班 2.5h', 781, 90, 24, { fill: '#7EE1BD', weight: 750, anchor: 'middle' })}
    </g>`;
  } else if (scene === 'ai') {
    markup += sectionHeading('04', 'AI 助理', '一句话', '帮你安排好', '会聊天，也真正懂这个 App', progress);
  } else if (scene === 'action') {
    const p = easeOutBack(progress * 3);
    markup += `<g opacity="${p}">
      ${pill('AI 正在理解你的需求', 82, 120, 355, '#FFFFFF', COLORS.primary)}
      <rect x="110" y="315" width="860" height="122" rx="36" fill="#5965E8"/>
      ${svgText('“下周六改成休息，顺便关掉闹钟”', 540, 391, 32, { fill: 'white', weight: 700, anchor: 'middle' })}
      <g transform="translate(110 ${lerp(1580, 1260, p)})">
        <rect width="860" height="360" rx="42" fill="white" stroke="#E3E5EE" stroke-width="2"/>
        ${svgText('变更预览', 40, 62, 30, { weight: 850 })}
        ${pill('等待确认', 650, 30, 160, '#FFF0D3', '#9A6411')}
        ${svgText('8月15日', 48, 142, 24, { fill: COLORS.muted, weight: 600 })}
        ${svgText('白班  →  休息', 260, 142, 30, { weight: 800 })}
        ${svgText('联动闹钟', 48, 204, 24, { fill: COLORS.muted, weight: 600 })}
        ${svgText('07:10  →  已暂停', 260, 204, 30, { weight: 800, fill: COLORS.green })}
        <rect x="40" y="258" width="780" height="74" rx="23" fill="#5965E8"/>
        ${svgText('确认后应用 · 随时可撤销', 430, 307, 28, { fill: 'white', weight: 750, anchor: 'middle' })}
      </g>
    </g>`;
  } else if (scene === 'end') {
    const p = easeOutBack(progress * 2.8);
    const fade = clamp((1 - progress) * 5);
    markup += `<g opacity="${fade}">
      ${logoMark(446, lerp(520, 410, p), 188, p)}
      ${svgText('班薪日历', 540, 755, 82, { anchor: 'middle', weight: 900, opacity: p })}
      ${svgText('把工作安排得明明白白', 540, 838, 40, { anchor: 'middle', weight: 650, fill: COLORS.primary, opacity: p })}
      ${pill('排班日历', 150, 1010, 220, '#FFFFFF', '#555C77', p)}
      ${pill('智能闹钟', 430, 1010, 220, '#FFFFFF', '#555C77', p)}
      ${pill('工资统计', 710, 1010, 220, '#FFFFFF', '#555C77', p)}
      ${pill('AI 助理', 405, 1090, 270, '#EEF0FF', COLORS.primary, p)}
      ${svgText('即将上线 · 敬请期待', 540, 1400, 32, { anchor: 'middle', weight: 700, fill: COLORS.muted, opacity: p })}
    </g>`;
  }

  const sceneDuration = sceneInfo(t).end - sceneInfo(t).start;
  const entryFlash = clamp(1 - progress * 7);
  const exitFlash = clamp((progress - .94) * 15);
  const flash = Math.max(entryFlash, exitFlash) * .72;
  markup += `<rect width="1080" height="1920" fill="white" opacity="${flash}"/>`;

  return Buffer.from(`<svg xmlns="http://www.w3.org/2000/svg" width="1080" height="1920">${markup}</svg>`);
}

async function renderFrame(frame, phoneAssets) {
  const t = frame / FPS;
  const info = sceneInfo(t);
  const progress = clamp((t - info.start) / (info.end - info.start));
  const tint = info.name === 'stats' ? 'green' : info.name === 'alarm' ? 'orange' : 'purple';
  const composites = [{ input: Buffer.from(backgroundSvg(t, tint)), left: 0, top: 0 }];

  const phoneName = scenePhoneName(info.name);
  if (phoneName) {
    const enter = easeOutCubic(progress * 3.2);
    const exit = easeInOutCubic(clamp((progress - .88) * 8));
    let top = Math.round(lerp(720, 350, enter) - exit * 55);
    let left = 175;
    if (info.name === 'action') {
      top = Math.round(lerp(620, 470, enter));
    }
    const shadow = Buffer.from(`<svg width="770" height="1580" xmlns="http://www.w3.org/2000/svg">
      <defs><filter id="s" x="-40%" y="-30%" width="180%" height="180%"><feGaussianBlur stdDeviation="28"/></filter></defs>
      <rect x="25" y="25" width="720" height="1515" rx="68" fill="#272B51" opacity=".23" filter="url(#s)"/>
    </svg>`);
    composites.push({ input: shadow, left: left - 20, top: top - 10 });
    composites.push({ input: phoneAssets[phoneName], left, top });
  }

  composites.push({ input: foregroundSvg(info.name, t, progress), left: 0, top: 0 });
  const pipeline = sharp({
    create: { width: WIDTH, height: HEIGHT, channels: 3, background: '#F4F5FB' },
  }).composite(composites).removeAlpha();

  if (frame === 507) {
    await pipeline.clone().png().toFile(COVER);
  }
  return pipeline.raw().toBuffer();
}

function writeWav(filePath) {
  const sampleRate = 48000;
  const channels = 2;
  const totalSamples = Math.floor(DURATION * sampleRate);
  const pcm = Buffer.alloc(totalSamples * channels * 2);
  const chords = [
    [261.63, 329.63, 392.00],
    [220.00, 261.63, 329.63],
    [174.61, 220.00, 261.63],
    [196.00, 246.94, 293.66],
  ];
  const beat = 0.75;
  for (let i = 0; i < totalSamples; i++) {
    const t = i / sampleRate;
    const chordIndex = Math.floor(t / 3) % chords.length;
    const chord = chords[chordIndex];
    const fadeIn = clamp(t / 1.2);
    const fadeOut = clamp((DURATION - t) / 2);
    const master = fadeIn * fadeOut;
    let pad = 0;
    for (let n = 0; n < chord.length; n++) {
      pad += Math.sin(2 * Math.PI * chord[n] * t) * 0.028;
      pad += Math.sin(2 * Math.PI * chord[n] * 0.5 * t) * 0.018;
    }
    const beatPhase = (t % beat) / beat;
    const arpNote = chord[Math.floor(t / beat) % chord.length] * 2;
    const arpEnv = Math.exp(-beatPhase * 7);
    const arp = Math.sin(2 * Math.PI * arpNote * t) * 0.055 * arpEnv;
    const pulse = Math.sin(2 * Math.PI * 55 * t) * 0.025 * Math.exp(-beatPhase * 10);
    const shimmer = Math.sin(2 * Math.PI * (arpNote * 2.01) * t) * 0.013 * arpEnv;
    const value = clamp((pad + arp + pulse + shimmer) * master, -1, 1);
    const left = Math.round(value * 32767);
    const right = Math.round((pad + arp * .92 + pulse + shimmer * .65) * master * 32767);
    const offset = i * 4;
    pcm.writeInt16LE(left, offset);
    pcm.writeInt16LE(clamp(right, -32767, 32767), offset + 2);
  }

  const header = Buffer.alloc(44);
  header.write('RIFF', 0);
  header.writeUInt32LE(36 + pcm.length, 4);
  header.write('WAVE', 8);
  header.write('fmt ', 12);
  header.writeUInt32LE(16, 16);
  header.writeUInt16LE(1, 20);
  header.writeUInt16LE(channels, 22);
  header.writeUInt32LE(sampleRate, 24);
  header.writeUInt32LE(sampleRate * channels * 2, 28);
  header.writeUInt16LE(channels * 2, 32);
  header.writeUInt16LE(16, 34);
  header.write('data', 36);
  header.writeUInt32LE(pcm.length, 40);
  fs.writeFileSync(filePath, Buffer.concat([header, pcm]));
}

async function main() {
  for (const screenPath of Object.values(screens)) {
    if (!fs.existsSync(screenPath)) throw new Error(`Missing screen: ${screenPath}`);
  }
  if (!ffmpegPath || !fs.existsSync(ffmpegPath)) throw new Error('FFmpeg binary is unavailable');

  console.log('Preparing phone assets...');
  const phoneAssets = {};
  for (const [name, screenPath] of Object.entries(screens)) {
    phoneAssets[name] = await createPhoneAsset(screenPath);
  }
  writeWav(AUDIO);

  const args = [
    '-y',
    '-f', 'rawvideo',
    '-pix_fmt', 'rgb24',
    '-s', `${WIDTH}x${HEIGHT}`,
    '-r', String(FPS),
    '-i', '-',
    '-i', AUDIO,
    '-c:v', 'libx264',
    '-preset', 'veryfast',
    '-crf', '19',
    '-pix_fmt', 'yuv420p',
    '-c:a', 'aac',
    '-b:a', '160k',
    '-shortest',
    '-movflags', '+faststart',
    OUTPUT,
  ];

  const ffmpeg = spawn(ffmpegPath, args, { stdio: ['pipe', 'pipe', 'pipe'] });
  let ffmpegError = '';
  ffmpeg.stderr.on('data', data => {
    ffmpegError += data.toString();
    if (ffmpegError.length > 12000) ffmpegError = ffmpegError.slice(-12000);
  });

  console.log(`Rendering ${TOTAL_FRAMES} frames...`);
  try {
    for (let frame = 0; frame < TOTAL_FRAMES; frame++) {
      const buffer = await renderFrame(frame, phoneAssets);
      const expectedSize = WIDTH * HEIGHT * 3;
      if (buffer.length !== expectedSize) {
        throw new Error(`Frame ${frame} has ${buffer.length} bytes; expected ${expectedSize}`);
      }
      if (!ffmpeg.stdin.write(buffer)) await once(ffmpeg.stdin, 'drain');
      if (frame % 90 === 0) console.log(`Progress ${Math.round(frame / TOTAL_FRAMES * 100)}%`);
    }
  } catch (error) {
    throw new Error(`${error.message}\nFFmpeg log:\n${ffmpegError}`);
  }
  ffmpeg.stdin.end();
  const [code] = await once(ffmpeg, 'close');
  if (code !== 0) throw new Error(`FFmpeg exited with ${code}\n${ffmpegError}`);
  console.log(`Video created: ${OUTPUT}`);
  console.log(`Cover created: ${COVER}`);
}

main().catch(error => {
  console.error(error.stack || error.message);
  process.exit(1);
});
