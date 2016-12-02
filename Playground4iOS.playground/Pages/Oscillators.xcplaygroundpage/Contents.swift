import AudioKit
import PlaygroundSupport


// 1. oscillator를 생성
let oscillator = AKOscillator()

// 2. AudioKit 엔진을 시작
AudioKit.output = oscillator
AudioKit.start()

oscillator.frequency = 500 // Hz
oscillator.amplitude = 1.0 // 0 ~ 1
oscillator.rampTime = 0.2

AKPlaygroundLoop(every: 0.5) {
  oscillator.frequency = oscillator.frequency == 500 ? 100 : 500
}

// 3. oscillator 시작
oscillator.start()


PlaygroundPage.current.needsIndefiniteExecution = true
