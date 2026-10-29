let soundEnabled = true;
        const AudioFX = {
            ctx: null,
            init() {
                if (!this.ctx) {
                    const AudioContext = window.AudioContext || window.webkitAudioContext;
                    if (AudioContext) this.ctx = new AudioContext();
                }
            },
            playPop() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    let osc = this.ctx.createOscillator();
                    let gain = this.ctx.createGain();
                    osc.connect(gain);
                    gain.connect(this.ctx.destination);
                    osc.type = 'sine';
                    osc.frequency.setValueAtTime(600, this.ctx.currentTime);
                    osc.frequency.exponentialRampToValueAtTime(1100, this.ctx.currentTime + 0.09);
                    gain.gain.setValueAtTime(0.3, this.ctx.currentTime);
                    gain.gain.exponentialRampToValueAtTime(0.01, this.ctx.currentTime + 0.09);
                    osc.start(this.ctx.currentTime);
                    osc.stop(this.ctx.currentTime + 0.09);
                } catch(e) {}
            },
            playCorrect() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    // Joyful musical xylophone chime
                    [523.25, 659.25, 783.99, 1046.50, 1318.51].forEach((freq, i) => {
                        let osc = this.ctx.createOscillator();
                        let gain = this.ctx.createGain();
                        osc.connect(gain);
                        gain.connect(this.ctx.destination);
                        osc.type = 'triangle';
                        osc.frequency.value = freq;
                        let start = this.ctx.currentTime + (i * 0.06);
                        gain.gain.setValueAtTime(0.25, start);
                        gain.gain.exponentialRampToValueAtTime(0.001, start + 0.28);
                        osc.start(start);
                        osc.stop(start + 0.28);
                    });
                } catch(e) {}
            },
            playZap() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    let osc = this.ctx.createOscillator();
                    let gain = this.ctx.createGain();
                    osc.connect(gain);
                    gain.connect(this.ctx.destination);
                    osc.type = 'sawtooth';
                    osc.frequency.setValueAtTime(900, this.ctx.currentTime);
                    osc.frequency.exponentialRampToValueAtTime(250, this.ctx.currentTime + 0.18);
                    gain.gain.setValueAtTime(0.3, this.ctx.currentTime);
                    gain.gain.exponentialRampToValueAtTime(0.01, this.ctx.currentTime + 0.18);
                    osc.start(this.ctx.currentTime);
                    osc.stop(this.ctx.currentTime + 0.18);
                } catch(e) {}
            },
            playWrong() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    // Funny cartoon boing
                    let osc = this.ctx.createOscillator();
                    let gain = this.ctx.createGain();
                    osc.connect(gain);
                    gain.connect(this.ctx.destination);
                    osc.type = 'sine';
                    osc.frequency.setValueAtTime(300, this.ctx.currentTime);
                    osc.frequency.exponentialRampToValueAtTime(160, this.ctx.currentTime + 0.25);
                    gain.gain.setValueAtTime(0.3, this.ctx.currentTime);
                    gain.gain.exponentialRampToValueAtTime(0.01, this.ctx.currentTime + 0.25);
                    osc.start(this.ctx.currentTime);
                    osc.stop(this.ctx.currentTime + 0.25);
                } catch(e) {}
            },
            playFanfare() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    const notes = [
                        { f: 523.25, d: 0.15 }, { f: 659.25, d: 0.15 }, { f: 783.99, d: 0.15 },
                        { f: 1046.50, d: 0.35 }, { f: 880.00, d: 0.15 }, { f: 1046.50, d: 0.6 }
                    ];
                    let curr = this.ctx.currentTime;
                    notes.forEach(n => {
                        let osc = this.ctx.createOscillator();
                        let gain = this.ctx.createGain();
                        osc.connect(gain);
                        gain.connect(this.ctx.destination);
                        osc.type = 'triangle';
                        osc.frequency.value = n.f;
                        gain.gain.setValueAtTime(0.25, curr);
                        gain.gain.exponentialRampToValueAtTime(0.001, curr + n.d);
                        osc.start(curr);
                        osc.stop(curr + n.d);
                        curr += n.d;
                    });
                } catch(e) {}
            }
        };
        function toggleSound() {
            soundEnabled = !soundEnabled;
            document.getElementById('btnSoundToggle').innerText = soundEnabled ? '🔊 Sound: ON' : '🔇 Sound: OFF';
            if (soundEnabled) AudioFX.playPop();
        }
        // Quiz Game State
        let currentAssignmentId = 0;
        let currentQuizId = 0;
        let passingScore = 20;
        let questions = [];
        let currentQIndex = 0;
        let correctCount = 0;
        let streak = 0;
        let timerSeconds = 600;
        let timerInterval = null;
        let answeredCurrent = false;
        let used5050 = false;
        let usedHint = false;
        const praises = [
            '🌟 YAHOO! THAT IS RIGHT! 🎉',
            '🍭 SWEET AS CANDY! 🍬',
            '🚀 SUPER DUPER AWESOME! 🌈',
            '🦁 BRAVE & SMART! 👑',
            '🦄 PURE MAGIC! ⭐'
        ];
        function openQuizArena(assignmentId, quizId, title, durationMinutes, passScore) {
            AudioFX.init();
            currentAssignmentId = assignmentId;
            currentQuizId = quizId;
            passingScore = passScore || 20;
            timerSeconds = (durationMinutes || 10) * 60;
            used5050 = false;
            usedHint = false;
            document.getElementById('btn5050').disabled = false;
            document.getElementById('btnHint').disabled = false;
            document.getElementById('arenaHintBox').style.display = 'none';
            document.getElementById('praiseBubble').style.display = 'none';
            document.getElementById('modalQuizTitle').innerText = title;
            document.getElementById('arenaPlayScreen').style.display = 'block';
            document.getElementById('arenaResultScreen').style.display = 'none';
            document.getElementById('quizArenaOverlay').style.display = 'flex';
            // Fetch questions from backend WebMethod
            fetch('student-tasks.aspx/GetQuizQuestions', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify({ quizId: quizId })
            })
            .then(res => res.json())
            .then(data => {
                let list = typeof data.d === 'string' ? JSON.parse(data.d) : data.d;
                if (list && list.length > 0) {
                    questions = list;
                    currentQIndex = 0;
                    correctCount = 0;
                    streak = 0;
                    startQuizSession();
                } else {
                    alert('No questions found for this quiz.');
                    closeQuizArena();
                }
            })
            .catch(err => {
                console.error(err);
                alert('Could not load quiz questions.');
                closeQuizArena();
            });
        }
        function startQuizSession() {
            renderQuestion();
            clearInterval(timerInterval);
            timerInterval = setInterval(() => {
                timerSeconds--;
                let m = Math.floor(timerSeconds / 60);
                let s = timerSeconds % 60;
                document.getElementById('arenaTimer').innerText = `${m < 10 ? '0' : ''}${m}:${s < 10 ? '0' : ''}${s}`;
                if (timerSeconds <= 0) {
                    clearInterval(timerInterval);
                    finishQuiz();
                }
            }, 1000);
        }
        function renderQuestion() {
            answeredCurrent = false;
            let q = questions[currentQIndex];
            document.getElementById('arenaQTracker').innerText = `🎈 Question ${currentQIndex + 1} of ${questions.length}`;
            document.getElementById('arenaProgressBar').style.width = `${((currentQIndex + 1) / questions.length) * 100}%`;
            document.getElementById('arenaQuestionText').innerText = q.QuestionText;
            document.getElementById('optAText').innerText = q.OptionA;
            document.getElementById('optBText').innerText = q.OptionB;
            document.getElementById('optCText').innerText = q.OptionC;
            document.getElementById('optDText').innerText = q.OptionD;
            document.getElementById('arenaHintBox').style.display = 'none';
            document.getElementById('praiseBubble').style.display = 'none';
            // Update Mascot
            const mascots = ['🐼', '🐱', '🦄', '🦁', '👑'];
            let mIndex = Math.min(streak, mascots.length - 1);
            document.getElementById('arenaAvatar').innerText = mascots[mIndex];
            document.getElementById('arenaStreak').innerHTML = streak >= 2 ?
                `<i class="fa-solid fa-fire" style="color:#ea580c;"></i> <strong style="color:#ea580c;">${streak}X SUPER COMBO!</strong>` :
                `<i class="fa-solid fa-fire" style="color:#ea580c;"></i> <span>Streak: ${streak}</span>`;
            document.getElementById('arenaScoreLive').innerText = `⭐ ${correctCount * 20} XP`;
            // Reset buttons
            ['A', 'B', 'C', 'D'].forEach(letter => {
                let btn = document.getElementById('btnOpt' + letter);
                btn.className = 'arena-opt-btn';
                btn.disabled = false;
            });
            document.getElementById('btnNextQuestion').style.visibility = 'hidden';
        }
        function use5050Lifeline() {
            if (used5050 || answeredCurrent) return;
            used5050 = true;
            document.getElementById('btn5050').disabled = true;
            AudioFX.playZap();
            let q = questions[currentQIndex];
            let correctLetter = q.CorrectOption.toUpperCase();
            let all = ['A', 'B', 'C', 'D'];
            let wrongOptions = all.filter(l => l !== correctLetter);
            wrongOptions.sort(() => Math.random() - 0.5);
            let toRemove = wrongOptions.slice(0, 2);
            toRemove.forEach(letter => {
                let btn = document.getElementById('btnOpt' + letter);
                btn.classList.add('faded-out');
                btn.disabled = true;
            });
        }
        function useHintLifeline() {
            if (usedHint || answeredCurrent) return;
            usedHint = true;
            document.getElementById('btnHint').disabled = true;
            AudioFX.playPop();
            let q = questions[currentQIndex];
            let correctLetter = q.CorrectOption.toUpperCase();
            let optText = q['Option' + correctLetter];
            document.getElementById('arenaHintText').innerText = `Look for: "${optText}"! It is the right one!`;
            document.getElementById('arenaHintBox').style.display = 'block';
        }
        function selectAnswer(selected) {
            if (answeredCurrent) return;
            answeredCurrent = true;
            let q = questions[currentQIndex];
            let isCorrect = selected.toUpperCase() === q.CorrectOption.toUpperCase();
            ['A', 'B', 'C', 'D'].forEach(letter => {
                let btn = document.getElementById('btnOpt' + letter);
                btn.disabled = true;
            });
            let chosenBtn = document.getElementById('btnOpt' + selected.toUpperCase());
            let correctBtn = document.getElementById('btnOpt' + q.CorrectOption.toUpperCase());
            if (isCorrect) {
                chosenBtn.classList.add('correct');
                correctCount++;
                streak++;
                AudioFX.playCorrect();
                // Show praise
                let p = praises[Math.floor(Math.random() * praises.length)];
                let pBubble = document.getElementById('praiseBubble');
                pBubble.innerText = p;
                pBubble.style.display = 'block';
            } else {
                chosenBtn.classList.add('wrong');
                if (correctBtn) correctBtn.classList.add('correct');
                streak = 0;
                AudioFX.playWrong();
            }
            const mascots = ['🐼', '🐱', '🦄', '🦁', '👑'];
            let mIndex = Math.min(streak, mascots.length - 1);
            document.getElementById('arenaAvatar').innerText = mascots[mIndex];
            document.getElementById('arenaStreak').innerHTML = streak >= 2 ?
                `<i class="fa-solid fa-fire" style="color:#ea580c;"></i> <strong style="color:#ea580c;">${streak}X SUPER COMBO!</strong>` :
                `<i class="fa-solid fa-fire" style="color:#ea580c;"></i> <span>Streak: ${streak}</span>`;
            document.getElementById('arenaScoreLive').innerText = `⭐ ${correctCount * 20} XP`;
            let btnNext = document.getElementById('btnNextQuestion');
            btnNext.style.visibility = 'visible';
            if (currentQIndex === questions.length - 1) {
                btnNext.innerHTML = `Finish Game 🏆`;
            } else {
                btnNext.innerHTML = `Next Fun Question <i class="fa-solid fa-arrow-right"></i>`;
            }
        }
        function nextQuestion() {
            AudioFX.playPop();
            if (currentQIndex < questions.length - 1) {
                currentQIndex++;
                renderQuestion();
            } else {
                finishQuiz();
            }
        }
        function finishQuiz() {
            clearInterval(timerInterval);
            document.getElementById('arenaPlayScreen').style.display = 'none';
            document.getElementById('arenaResultScreen').style.display = 'block';
            let totalQ = questions.length;
            let scorePct = Math.round((correctCount / totalQ) * 100);
            let isPassed = scorePct >= passingScore;
            document.getElementById('resScorePct').innerText = `${scorePct}%`;
            document.getElementById('resCorrectCount').innerText = `${correctCount} / ${totalQ}`;
            let rankBadge = document.getElementById('resRankBadge');
            if (scorePct === 100) {
                rankBadge.innerText = '👑 SUPER DUPER CHAMPION!';
            } else if (scorePct >= 60) {
                rankBadge.innerText = '🌟 STAR MASTER!';
            } else {
                rankBadge.innerText = '🎈 SMART PLAYER!';
            }
            if (isPassed) {
                document.getElementById('resTitle').innerText = '🎉 You Won the Game!';
                document.getElementById('resDesc').innerText = `Hooray! You earned ${correctCount * 20} XP with ${scorePct}% score. You did super great!`;
                document.getElementById('resStatusBadge').innerText = 'PASSED 🎉';
                document.getElementById('resStatusBadge').style.color = '#10b981';
                AudioFX.playFanfare();
                triggerConfetti();
            } else {
                document.getElementById('resTitle').innerText = '⚡ Play Again!';
                document.getElementById('resDesc').innerText = `You scored ${scorePct}%. Try once more, it's super easy!`;
                document.getElementById('resStatusBadge').innerText = 'RETRY';
                document.getElementById('resStatusBadge').style.color = '#ef4444';
            }
        }
        function finalizeQuizSubmission() {
            let totalQ = questions.length;
            let scorePct = Math.round((correctCount / totalQ) * 100);
            // Populate hidden ASP.NET postback fields and trigger form submission
            document.getElementById('hfQuizAssignmentId').value = currentAssignmentId;
            document.getElementById('hfQuizScore').value = scorePct;
            document.getElementById('hfQuizCorrectCount').value = correctCount;
            document.getElementById('hfQuizTotalQuestions').value = totalQ;
            document.getElementById('btnHiddenSubmitQuiz').click();
        }
        function closeQuizArena() {
            clearInterval(timerInterval);
            document.getElementById('quizArenaOverlay').style.display = 'none';
        }
        // Lightweight Colorful Confetti Particles Engine
        function triggerConfetti() {
            const canvas = document.getElementById('confettiCanvas');
            const ctx = canvas.getContext('2d');
            canvas.width = canvas.parentElement.offsetWidth;
            canvas.height = canvas.parentElement.offsetHeight;
            const particles = [];
            const colors = ['#ec4899', '#8b5cf6', '#3b82f6', '#10b981', '#f59e0b', '#06b6d4', '#f43f5e', '#a855f7'];
            for (let i = 0; i < 90; i++) {
                particles.push({
                    x: canvas.width / 2,
                    y: canvas.height / 2,
                    vx: (Math.random() - 0.5) * 16,
                    vy: (Math.random() - 0.7) * 18,
                    color: colors[Math.floor(Math.random() * colors.length)],
                    size: Math.random() * 10 + 4,
                    rotation: Math.random() * 360,
                    rSpeed: (Math.random() - 0.5) * 12
                });
            }
            let frame = 0;
            function animateConfetti() {
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                particles.forEach(p => {
                    p.x += p.vx;
                    p.y += p.vy;
                    p.vy += 0.32; // gravity
                    p.rotation += p.rSpeed;
                    ctx.save();
                    ctx.translate(p.x, p.y);
                    ctx.rotate((p.rotation * Math.PI) / 180);
                    ctx.fillStyle = p.color;
                    ctx.fillRect(-p.size / 2, -p.size / 2, p.size, p.size);
                    ctx.restore();
                });
                frame++;
                if (frame < 150) {
                    requestAnimationFrame(animateConfetti);
                } else {
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                }
            }
            animateConfetti();
        }
