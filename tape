<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TIMARHANE // Mavi Randevu</title>
    <style>
        :root {
            --cyber-blue: #00f0ff;
            --matrix-green: #00ff66;
            --neon-glow: 0 0 10px rgba(0, 240, 255, 0.6);
            --terminal-bg: rgba(10, 14, 23, 0.82);
        }

        * { box-sizing: border-box; }

        body {
            margin: 0;
            padding: 0;
            background-color: #05070b;
            font-family: 'Courier New', Courier, monospace;
            color: #ffffff;
            min-height: 100vh;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            overflow: hidden;
            position: relative;
        }

        /* TABAN KATMAN: SİNEMATİK ASIL GÖRSEL */
        .cyber-universe-bg {
            position: fixed;
            top: 0; left: 0; width: 100vw; height: 100vh;
            background-image: url('tape_1.png'); 
            background-size: cover;
            background-position: center;
            z-index: 1;
            /* Nefes alma motoru aktif */
            animation: streetGlimmer 8s ease-in-out infinite alternate; 
        }

        /* SEÇİCİ NEON IŞIKLANDIRMA MOTORU */
        .neon-pulse-engine {
            position: fixed;
            top: 0; left: 0; width: 100vw; height: 100vh;
            z-index: 2;
            pointer-events: none;
            background: radial-gradient(circle at 75% 45%, rgba(0, 240, 255, 0.4) 0%, rgba(0, 255, 102, 0.08) 30%, transparent 65%);
            mix-blend-mode: color-dodge; 
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .track-playing .neon-pulse-engine {
            opacity: 1;
            animation: cyberBeaconSTORM 2.5s steps(1, end) infinite;
        }

        /* MATRIX SİNYAL AKIŞI */
        #matrixCanvas {
            position: fixed;
            top: 0; left: 0; width: 100vw; height: 100vh;
            z-index: 3;
            opacity: 0.12;
            pointer-events: none;
        }

        /* CRT Cam Izgarası */
        body::before {
            content: " ";
            display: block;
            position: fixed;
            top: 0; left: 0; bottom: 0; right: 0;
            background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.35) 50%);
            z-index: 9999;
            background-size: 100% 4px;
            pointer-events: none;
            mix-blend-mode: overlay;
            animation: crtFlicker 0.15s infinite;
        }

        /* HAVADA ASILI SİBER KAPSÜL PANEL */
        .main-interface {
            width: 100%;
            max-width: 510px;
            margin-left: 5%;
            padding: 24px;
            background: var(--terminal-bg);
            border: 1px solid rgba(0, 240, 255, 0.2);
            box-shadow: 0 0 35px rgba(0, 0, 0, 0.9);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            z-index: 10;
            border-radius: 4px;
        }

        header {
            border-bottom: 1px solid rgba(0, 240, 255, 0.25);
            padding-bottom: 12px;
            margin-bottom: 20px;
        }

        .sys-title {
            font-size: 1.35rem;
            color: var(--cyber-blue);
            font-weight: bold;
            letter-spacing: 3px;
            margin: 0;
            text-shadow: var(--neon-glow);
        }

        .sys-status {
            font-size: 0.75rem;
            color: var(--matrix-green);
            margin-top: 4px;
            opacity: 0.8;
        }

        .audio-wrapper {
            background: rgba(0, 0, 0, 0.65);
            border: 1px solid rgba(0, 255, 102, 0.25);
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 2px;
        }

        .track-info {
            font-size: 0.8rem;
            color: var(--cyber-blue);
            margin-bottom: 8px;
            display: flex;
            justify-content: space-between;
        }

        audio {
            width: 100%;
            height: 32px;
            filter: invert(1) hue-rotate(180deg) saturate(1.4);
            opacity: 0.9;
        }

        /* 24px Kusursuz Satır Kilitli Alan */
        .lyrics-container {
            height: 336px;
            overflow: hidden;
            position: relative;
        }

        .scroller-engine {
            position: absolute;
            width: 100%;
            top: 0;
            transition: transform 0.38s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .lyrics-block {
            margin-bottom: 24px;
            opacity: 0.25;
            transition: all 0.3s ease;
            font-size: 0.95rem;
            line-height: 24px;
            text-align: left;
        }

        .lyrics-block.active {
            opacity: 1;
            color: #ffffff;
        }

        .lyrics-block.active b {
            color: var(--cyber-blue);
            text-shadow: 0 0 6px rgba(0, 240, 255, 0.7);
        }

        footer {
            margin-top: 20px;
            font-size: 0.7rem;
            color: rgba(255, 255, 255, 0.35);
            border-top: 1px dashed rgba(255, 255, 255, 0.1);
            padding-top: 12px;
            display: flex;
            justify-content: space-between;
        }

        /* --- ANIMASYON REÇETELERİ --- */
        @keyframes crtFlicker {
            0% { opacity: 0.96; }
            50% { opacity: 1; }
            100% { opacity: 0.97; }
        }

        /* Şehir Işıkları ve Islak Yolun Sinematik Nefes Alıp Verme Hareketi */
        @keyframes streetGlimmer {
            0% { filter: brightness(0.93) contrast(0.98); transform: scale(1); }
            100% { filter: brightness(1.05) contrast(1.06); transform: scale(1.02); }
        }

        @keyframes cyberBeaconSTORM {
            0%, 100% { opacity: 0.4; filter: saturate(1); }
            5% { opacity: 0.9; filter: saturate(1.5) brightness(1.2); }
            8% { opacity: 0.3; }
            12% { opacity: 1; filter: saturate(1.8) brightness(1.3); }
            15% { opacity: 0.5; }
            50% { opacity: 0.6; }
            55% { opacity: 0.9; filter: saturate(1.4); }
            58% { opacity: 0.4; }
        }

        @media (max-width: 900px) {
            body { justify-content: center; padding: 15px; background-position: center; }
            .main-interface { margin-left: 0; width: 100%; }
        }
    </style>
</head>
<body id="cyberBody">

    <div class="cyber-universe-bg"></div>
    <div class="neon-pulse-engine"></div>
    <canvas id="matrixCanvas"></canvas>

    <div class="main-interface">
        <header>
            <div class="sys-title">TIMARHANE_OS v6.5</div>
            <div class="sys-status">SYS.LOC: ISTANBUL // TOTAL_AMBIENT_LIVE</div>
        </header>

        <div class="audio-wrapper">
            <div class="track-info">
                <span>SIGNAL: Onno v3.mp3</span>
                <span style="color: var(--matrix-green);">07:59 AUDIO</span>
            </div>
            <audio id="cyberPlayer" controls>
                <source src="Onno v3.mp3" type="audio/mpeg">
                Sinyal donanımı kilitli.
            </audio>
        </div>

        <div class="lyrics-container">
            <div class="scroller-engine" id="scrollerEngine">
                <div class="lyrics-block active" data-time="0">
                    <span style="color: #4a5568; font-style: italic;">... sinyal aranıyor ...</span>
                </div>
                <div class="lyrics-block" data-time="20">
                    Sabah erkenden kalktık yine,<br>
                    Cebimiz dar ama gülümsemek bedava.<br>
                    Trafik çıldırmış, ekmek pahalanmış,<br>
                    Bu açık hava tımarhanesinde...<br>
                    Sistem mi çökmüş, veriler mi çalınmış?<br>
                    <b>Aşk bu be güzelim, siber dinler mi hiç?</b>
                </div>
                <div class="lyrics-block" data-time="55">
                    <span style="color: var(--matrix-green); font-weight: bold; letter-spacing: 2px;">Din! Din! Din!</span><br>
                    <b>Dinlemez dinler!</b>
                </div>
                <div class="lyrics-block" data-time="78">
                    Şehirleri dar etseler de,<br>
                    Uydudan, Mobese'ye hepimizi izleseler de...<br>
                    Yine daldık o muzip bilmeceye...<br>
                    İster iste, isteme —<br>
                    Yapaya doğru evriliyoruz!
                </div>
                <div class="lyrics-block" data-time="125">
                    Birileri nefes alma dediği için<br>
                    nefes almayacak değiliz —<br>
                    <b>Nefes alıyoruz!<br>
                    Hâlâ sevebiliyoruz!<br>
                    İnsanız biz ve boyun eğmiyoruz!</b>
                </div>
                <div class="lyrics-block" data-time="180">
                    <span style="color: #4a5568; font-style: italic;">... interlude ...</span>
                </div>
                <div class="lyrics-block" data-time="230">
                    Uyuyan güzeller, uyandırılamayacak kadar reziller.<br>
                    Rüyalarında bile dünyayı fethetme peşindeler.<br>
                    Cehalet mutluluktur —<br>
                    Kafası basmayana,<br>
                    Biat kültüründe,<br>
                    Kurban olana.
                </div>
                <div class="lyrics-block" data-time="295">
                    Ne zaman baktın ki yüzüne,<br>
                    Bu toprağın...<br>
                    Bu yağmurun...<br><br>
                    Çırılçıplak duruyordu hep,<br><br>
                    Biz giydirdik üstüne.
                </div>
                <div class="lyrics-block" data-time="360">
                    Birileri nefes alma dediği için<br>
                    nefes almayacak değiliz —<br>
                    <b>Nefes alıyoruz!<br>
                    Hâlâ sevebiliyoruz!<br>
                    İnsanız biz ve boyun eğmiyoruz!</b>
                </div>
                <div class="lyrics-block" data-time="425">
                    Hadi gel... Kodları kıralım...<br>
                    Saksafon gibi çın-lı-yo-ruz...<br>
                    Bu si-mü-las-yon-da...<br><br>
                    Gülümse şimdi... Tam da böyle...
                </div>
            </div>
        </div>

        <footer>
            <span>PROT: MAVI_RANDEVU</span>
            <span>© 2026 TIMARHANE</span>
        </footer>
    </div>

    <script {nonce}>
        // MATRIX YAĞMURU
        const canvas = document.getElementById('matrixCanvas');
        const ctx = canvas.getContext('2d');
        function resizeCanvas() { canvas.width = window.innerWidth; canvas.height = window.innerHeight; }
        resizeCanvas();
        window.addEventListener('resize', resizeCanvas);

        const alphabet = "ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎ1023456789".split("");
        const fontSize = 14;
        const columns = canvas.width / fontSize;
        const rainDrops = Array.from({ length: columns }).fill(1);

        function drawMatrix() {
            ctx.fillStyle = 'rgba(5, 7, 11, 0.05)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#00ff66';
            ctx.font = fontSize + 'px monospace';
            for (let i = 0; i < rainDrops.length; i++) {
                const text = alphabet[Math.floor(Math.random() * alphabet.length)];
                ctx.fillText(text, i * fontSize, rainDrops[i] * fontSize);
                if (rainDrops[i] * fontSize > canvas.height && Math.random() > 0.975) rainDrops[i] = 0;
                rainDrops[i]++;
            }
        }
        setInterval(drawMatrix, 30);

        // SENKRONİZASYON MOTORU
        const player = document.getElementById('cyberPlayer');
        const blocks = document.querySelectorAll('.lyrics-block');
        const engine = document.getElementById('scrollerEngine');
        const cyberBody = document.getElementById('cyberBody');

        player.addEventListener('play', () => { cyberBody.classList.add('track-playing'); });
        player.addEventListener('pause', () => { cyberBody.classList.remove('track-playing'); });

        player.addEventListener('timeupdate', () => {
            const currentTime = player.currentTime;
            let activeIndex = 0;
            blocks.forEach((block, index) => {
                if (currentTime >= parseFloat(block.getAttribute('data-time'))) activeIndex = index;
            });
            blocks.forEach((block, index) => {
                if (index === activeIndex) {
                    if (!block.classList.contains('active')) {
                        block.classList.add('active');
                        engine.style.transform = `translateY(-${block.offsetTop}px)`;
                    }
                } else block.classList.remove('active');
            });
        });
    </script>
</body>
</html>
