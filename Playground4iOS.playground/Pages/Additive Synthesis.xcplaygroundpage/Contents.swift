import AudioKit
import PlaygroundSupport

func createAndStartOscillator(frequency: Double) -> AKOscillator {
  let oscillator = AKOscillator()
  oscillator.frequency = frequency
  oscillator.start()
  return oscillator
}

let frequences = (1...5).map{ $0 * 261.63 }

let oscillators = frequences.map {
  createAndStartOscillator(frequency: $0)
}

let mixer = AKMixer()
oscillators.forEach { mixer.connect($0) }

let envelope = AKAmplitudeEnvelope(mixer)
envelope.attackDuration = 0.01
envelope.decayDuration = 0.1
envelope.sustainLevel = 0.1
envelope.releaseDuration = 0.3

AudioKit.output = envelope
AudioKit.start()

AKPlaygroundLoop(every: 0.5) {
  if (envelope.isStarted) {
    envelope.stop()
  }
  else {
    envelope.start()
  }
}

class PlaygroundView: AKPlaygroundView {
  override func setup() {
    addTitle("Harmonics")

    oscillators.forEach {
      oscillator in
      let harmonicSlider = AKPropertySlider(
        property: "\(oscillator.frequency) Hz",
        value: oscillator.amplitude
      ) { amplitude in
        oscillator.amplitude = amplitude
      }
      addSubview(harmonicSlider)
    }
  }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()

