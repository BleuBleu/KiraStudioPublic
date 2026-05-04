# Generators Reference

This page contains some reference on all the generators present in the app. Generators are little modules able to produce one type of sound and are the building blocks of instruments. 

Their outputs are combined based on the blend mode specified, like photoshop layers, to generate the audio of an instrument.

## Emulation Accuracy

For generators emulating actual hardware, some notes about the emulation accuracy will be provided for each.

Please note that in-general, for these retro consoles, this app is not trying to achieve high-accuracy emulation. It provides users with a lot of "fakebit" freedoms. Thereform some compromises are made to strike a balance between fidelity and ease-of-use. The goal is to sound "good enough" too fool non-expert or people not looking for flaws. For accurate emulation, trackers and other dedicated tools should be used.

Here are some general notes on emulation accuracy that apply to all the hardware-specific generators (NES, Yamaha, Game Boy, etc.). More specific notes will be provided on each system in their respective sections.

- Each note playing will emulate its own individual hardware channel. For instance, a 3 notes chord will internally spin up 3 completely separate hardware systems, each generating the audio of their respective note/channel, then the output will be recombined. This is different from how real hardware would behave, and removes the possibility of having channel interactions (multiplexing, exotic DAC behaviors, etc.) that are present on some systems. 

- On the plus side, this removes any polyphony limitation that these systems impose. You are responsible for limiting the polyphony yourself if you truly want to sound retro.

- The app give you infinite ROM/disk space. That being said, this does not mean you can play samples or use wavetables longer than what the original systems could do. It simply mean you somehow have a very large cartridge or disk to work with.

- Volumes are not hardware accurate at all. Some consoles had very specific volume ratios between the different channels, sometimes with non-lienar effects thrown in. KiraStudio outputs almost every generator at -12dB peak-to-peak. You are responsible for adjusting those to match the hardware you are trying to replicate.

- When systems can run in multiple regions (NTSC, PAL, etc), only the native version will be provided. For Japanese system, this mean NTSC only.

> TODO : There will be more here.

# Common Parameters

Some parameters are presents on multiple generators and will documented here to avoid repetitions.

## General Parameters

These paremeters may be present on almost any generators.

* **Envelope** : This is the main volume envelope of the generator, and needs to be driven by an ADSR envelope, a custom curve or a sequence. This volume will appear in different unit depending on the type of generator. It may be a simple linear amplitude (0 to 100%) for Generics generators, while it may range from 0 to 15 for an NES generator to better help you match the hardware. In term of amplitude, the Envelope parameter does the exact sample thing as the Volume parameter, but it is also what dictates the lifetime of a note. Any note whose Envelope parameter reaches zero while in its release phase will be killed and freed.
* **Volume** : This is an additionnal volume control. You can use it to balance the volume of this generator with respect to other, or automate it to create a tremolo effect. Unlike the Envelope parameter, this volume has no effect on the lifetime of a note. A note with zero volume will still keep playing and count in the total polyphony of a channel.
* **Pan** or **Balance** : This parameter will appear as Pan for generators that are inherently mono, but can be expanded to stereo (ex: Generic Saw) and it will appear as Balance for generators whose output is natively Stereo  but can be further re-balanced (ex: SoundFonts). Panning distributes a mono signal in a certain proportion to the L/R channels, while balancing takes a stereo signal and attenuates one side.

## Pitch Parameters

These parameters regroup parameters that can either alter the pitch of the note being played, or control how the generator responds to the note being played.

* **Transpose** : This is a coarse transposition parameter, in semitones. This can be used to play notes 1 octave higher than they should, for example. Can be automated to create arpeggio-type effect.
* **Tune** : This is a more fine-grained transposition parameter, in cents. Can be automated to create vibrato effects, for example. Behind the scene, transpose and tune and combined and are one and the same. They are simply split into coarse/fine for convenience.
* **Group** : Each generator can be part of a _Generator Group_. There are up to 8 groups and each note in the piano roll can trigger a single group. This allows intruments to produce different sounds by only activating certain generator. Example uses cases : a fingered bass that can be slapped occasionally, strings that can sometimes play pizzicato, etc. This avoid creating multiple instruments when they are logically the same.
* **Base Pitch** : Usually, a generator will use the note being played to determine the frequency it should produces. This settings allows you to override this behavior and have a generator output a fixed note. This can be useful when combining multiple generators and wanting to keep one at a fixed frequency, regardless of the note being played. For example, one could create a "Tim Follin" snare by have a noise generator playing a fixed frequency, along with a rapidly descending triangle or square wave that _does_ start at the note being played.

## Filter Parameters

These parameter allows you to have apply various filter to the generator. These filter are the exact same that you would find in the [Filter Effect](effects.md#filter) so they will not be documented here.

The main different here is that the filter on the generator is applied on each individual note of that generator, while the Filter Effect is applied on the entire audio output of a channel. 

This mean that you can use Trigger envelopes to affects the filter frequency or Q/bandwidth, which is not possible on the effect since by that time, all channel audio has been mixed and there are no more notion of notes starting and stopping.

## Bandlimit Parameters

For some retro generator or generators with large discontinuities (square waves, saws/triangle waves with steps, etc), we synthesise the audio using a band limited step (BLEP) and the Bandlimit parameters will be editable. The basic principle is explained [here](https://www.slack.net/~ant/bl-synth/) by the idea of this technique is to generate the audio while keeping the frequencies below the Nyquist, reducings aliasing, without having to supersample or filter. 

This technique also takes care of DC removal, which is required on some hardware that output audio with a DC component. All of these help to more closely matches the behavior of the various hardware KiraStudio handles.

Note that while these provide some form of low-pass/high-pass functionality, these cannot and should not be used as filter effects. These settings are used during the actual synthesis of the waveform and should not be thought of as an audio effect.

* **Treble Attenuation** : How much to attenuate high-frequencies during the waveform generation (low-pass filter).
* **Treble Rolloff Frequency** : The frequency (in Hz) at which high-frequencies start to be attenuated by the low-pass filter. 
* **Bass Frequency / DC Removal** : The frequency (in Hz) of the high-pass filter used during the waveform generator, used to remove DC and center the waveform.
* **Recenter DC after notes** : When enabled, will smoothly recenter the DC after a note to eliminates popping on abrupt releases.

## Blend Parameters

When multiple generators are used on an instrument, their respective output are usually summed together to get the final output. While summing is the default, it is not the only options. Much like Photoshop layers that can be blended in various way, so can generators. 

For any generator that is not the first (top) in the stack, the Blend parameters will be editable. 

* **Blend Mode** : How this generator blends with the previous one (above) on the stack. There are currently only 2 blend mode : **Add** and **Mix**. Add is the default and simply sums the audio, Mix performs alpha blending (linear interpolation) using the Alpha parameter.
* **Alpha** : Alpha parameter of the blend, its effect will vary depending on the blend mode. For Add it will simply act as a volume adjustment, for Mix it will be the blend factor of the linear interpolation (`output = gen1 * (1 - alpha) * gen2 * alpha`). This parameter can be automated to create interesting effects.

# Generic Generators

The generic generators are basic synths provided with the app. They do not try to emulate any particular device. They are meant easy to use and customizable. 

## ![](images/GeneratorSaw.png#header) Saw

A generic sawtooth waveform with configurable steps and direction, ideal for bright leads, rich basses, and harmonically complex sounds typical of subtractive synthesis.

When the saw is smooth (The steps parameter is zero), bandlimiting is achieved using a simple PolyBLEP. When it is stepped, it uses a a band limited step (BLEP) and the bandlimiting parameters will be editable. 

* **Invert Polarity** : When enabled, the saw will go down, instead of up. 
* **Steps** : The number of steps to divide the saw ramp into, 0 is perfectly smooth and low non-zero values can help sound more retro.

##![](images/GeneratorSquare.png#header) Square

A generic pulse waveform with precisely adjustable duty cycle, great for clear melodies, rich harmonies, and classic chiptune tones with adjustable brightness and character.

* **Invert Polarity** : When enabled, flips the polarity of the square wave.
* **Duty Cycle** : The percentage of time the pulse waveform is kept high. Sometimes called Pulse Width when talking in absolute time duration.

## ![](images/GeneratorTriangle.png#header) Triangle

A generic triangle waveform that can be smoothed or stepped, perfect for soft basses, gentle leads, and clean, rounded tones with minimal harmonics.

When the triangle is smooth (The steps parameter is zero), no bandlimiting technique is used. When it is stepped, it uses a a band limited step (BLEP) and the bandlimiting parameters will be editable. 

* **Invert Polarity** : When enabled, flips the polarity of the triangle wave.
* **Steps** : The number of steps to divide the triangle waveform into, 0 is perfectly smooth and low non-zero values can help sound more retro.

## ![](images/GeneratorSine.png#header) Sine

A generic sine waveform producing a pure tone with no harmonics, ideal for sub-basses, smooth leads, and clean modulation or layering in synthesis.

* **Invert Polarity** : When enabled, flips the polarity of the sine wave.

## ![](images/GeneratorSuperSaw.png#header) SuperSaw

A generic supersaw oscillator with adjustable voice count, detune spread, and blend between center and detuned voices. Can use waveforms beyond a traditional saw.

While this take inspiration from the Roland JP-8000, it is not trying to match its sound in any meaningful way. This generation simply takes the general idea of combining multiple oscillators with some detune and mix settings, something you could also do by using multiple generators on an instrument.

* **Oscillator Count** : The number of oscillators to combine. The original JP-8000 used 7. 
* **Detune** : The maximum detuning to apply. At maximum value, outermost saws are +/- 50 cents off and the inner saws are proportionaly less detuned.
* **Mix** : How loud the center saw is compared to the outer saws.
* **Mix Falloff** : How the outer saws taper off as they get further from the center. The original JP-8000 had no falloff.
* **Stereo Width** : How much to pan the outer saws L/R. At zero the audio is mono, at 100% the outermost saws are only audible in their respective L/R channel.
* **Waveform** : The waveform to use.
* **Duty Cycle** : When using a square waveform, the duty cycle of the square wave.

## ![](images/GeneratorFM4Op.png#header) 2/3/4-OP FM

A generic 2/3/4-operator FM synth inspired by classic Yamaha chips, offering more control over algorithms, modulation, and custom operator waveforms beyond simple sines for deep sound design.

This section will not try to explain the concept of FM synthesis here, I will refer you to this fantastic video by Andrew Huang which summarizes the idea in unreal 4 minutes. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/vvBl3YUBUyY?si=y36fsscdkvlV9Fqz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen style="width: 90%; aspect-ratio: 16/9; display: block; margin: 0 auto;"></iframe>

A little operator diagram representing how the various operators are connected is shown. In the diagram, each box is an operator. Operators connecting to other operators modulate them and are called Modulators. Modulators are directly inaudible, you only hear the effect they have on other operators. Operators outputting to the bottom are called Carriers and contribute to the final audio. Operator 1 will be shown with a line connecting to itself to represent the optional feedback.

<br/>
### General Parameters:

* **Algorithm** : Defines how multiple operators are connected, shaping modulation paths and timbre. 
* **LFO Frequency** : An LFO is provided and can be use to create tremolo or vibrato on the operators that opt-in. It is important to understand that this is simple and quality of life feature, and regular automation curves can be used to achieve a similar effect. 
* **Clip Mode** : Offers different clipping mode for when the signal goes outside of the valid range. Clipping can be turned off, applied after each operator, or just once on the final combined output of all operators.
* **OP1 Feedback** : How much OP1's output will be fed back to itself. Low values can make the waveform sound richer, high values can create noise

### Operator (OP) Parameters:

* **Envelope** : The volume envelope of this operator. On desktop the operators envelope will always be pinned with a mini-editor. You can open the main envelope editor by pressing the "Edit..." button. For technical reason, the operator's envelope cannot be custom curves or sequences. 
* **Level** : Intensity or volume of this operator. For modulators, this control how strong its effect will be on the downstream operator, for carrier this simply is a volume.
* **Waveform** : The waveform to use in the FM synthesis for this operator. Traditional FM synthesis uses sine waves, but others are available here. Please note the the curve editor isnt able to perfectly represent some curves like sine waves. There is a 1-2% approximation error, which is enough to be audible. When sticking to the presents (Sine, Sine Absolute, etc.), the app will use the analitical form of the curve, removing this error. When using a custom preset, it will use the curve, which may introduce extra audible harmonics. 
* **Octave** : Coarse tuning of this operator frequency, in octaves. For example, +1 octave means a 2x frequency scaling.
* **Semitone** : Finer tuning of this operator frequency, in semitones. For example, +6 semitones means a 1.5x frequency scaling.
* **Fine Tune** : Finest tuning of this operator frequency, in cents. Small values can sound similar to the _Detune_ offered by other FM devices.
* **Tremolo Amount** : How much the LFO of the generator (General tab) affects the volume/level of this operator. You could achieve a tremolo by automating the Level parameter as well.
* **Vibrato Amount** : How much the LFO of the generator (General tab) affects the pitch of this operator. You could make vibrato by automating the Fine Tine parameter as well.

## ![](images/GeneratorWaveTable.png#header) WaveTable

A generic wavetable synth using 4 to 8-bit waveforms, capable of cycling through multiple tables at a fixed rate for evolving, dynamic, and textured sounds. 

The concept of a WaveTable will not be explained here, please refer to the [wavetable section](wavetable.md) of the documentation for more information.

* **Edit Wavetable** : Press this button to open the wave table editor.

## ![](images/GeneratorSample.png#header) PCM Sampler

A generic PCM (Pulse-Coded Modulation) synth. Assign PCM samples to keys of the piano and optionally extend them over a range to have them be automatically pitched up/down. A optional filter (low-pass, high-pass, band-pass, knotch) is available.

The PCM sampler is one of the few sampler offered in KiraStudio. This one supports playback of 32-bit floating point PCM samples. The sample editing workflow is covered in the [samples section](samples.md) of the documentation.

* **Edit Sample Map** : Press this button to open sample map editor.

## ![](images/GeneratorNoise.png#header) Noise

A generic noise generator supporting white, pink, brown, and LFSR noise types, with flexible shaping and optional pitch tracking, allowing noise to follow musical notes for tonal or percussive synthesis.

* **Mode** : The noise algorithm to use. The app currently offers **White**, **Pink**, **Brown** and **LFSR**. LFSR is recommended if you are trying to achieve a retro gaming sound.
* **Pitch Tracking** : When enabled, the noise will match the frequency of the note playing. When disabled, will generate 1 new noise value per audio sample.
* **Octave Shift** : Offsets the noise pitch by an entire octave, allowing you to play lower/higher notes with the piano.
* **LFSR Bits** : Number of bits in the LFSR noise generators. Less bit sounds more tonal or metallic, more bits sounds more like white noise. There are pretty much presets that can mimic some retro-gaming hardware.

## ![](images/GeneratorExpression.png#header) 8-bit Calculator

A generic integer-based programmable 8-bit sound generator similar to [Viznut's Bytebeat](https://countercomplex.blogspot.com/2011/10/algorithmic-symphonies-from-one-line-of.html) and [Caustic's 8-bit Synth](https://www.youtube.com/watch?v=4K9C3OBCDDc). 

Enter a custom function that takes the current time (t) as an input and outputs an amplitude value in the 0-255 range. A additional variable (x) is also provided and may be automated.

Here are some examples of earlyfunctions/formulas that Viznut found.

<iframe width="560" height="315" src="https://www.youtube.com/embed/GtQdIYUtAHg?si=jOAqjdWdPKOlkoeU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen style="width: 90%; aspect-ratio: 16/9; display: block; margin: 0 auto;"></iframe>

<br/>

For a tutorial on how to use the 8-Bit Calculator, please check out this great video from Caustic's 8-Bit Synth, which uses the same idea. 

Please do note that the operator precedence in Caustic is non-standard and you will have to change the Operator Precedence setting (or add extra parentheses) if you want to replicate their results. Also, Caustic supports having 2 formulas at the same time (A/B), you can replicate the same by having 2 generators in KiraStudio.

<iframe width="560" height="315" src="https://www.youtube.com/embed/4K9C3OBCDDc?si=o3oA-EvzsF3casn3" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen style="width: 90%; aspect-ratio: 16/9; display: block; margin: 0 auto;"></iframe>

<br/>

## ![](images/GeneratorSoundFont.png#header) SoundFont

A generic SoundFont synth supporting both SF2 and SF3 (OGG/Vorbis compressed). 

The synth supports most of the SounfFont features with a few exception. Modulators are only evaluated at key-on, so modulators changing over time or affected by MIDI CCs while the note is playing are currently ignored. There is also currently no way ot provinding inputs to the MIDI CCs at the moment. 

Chorus/reverb effects are purposely ignored since you can add those effect yourself in KiraStudio. 

A built-in SF3 version of the [GeneralUser-GS by S. Christian Collins](https://www.schristiancollins.com/generaluser) is provided. Please go and support their amazing work.

* **SoundFont** : The soundfont file to use. A warning here means the application could not load the file correctly. 
* **Preset** : The soundfont preset (instrument) to use. Names of presets needs to be unique, as required [by the specification](https://raw.githubusercontent.com/davy7125/soundfont-standard-v3/master/sfspec24.pdf), SoundFonts with duplicated preset names may sometimes pick the wrong one.

# Yamaha Generators

This section will cover the various Yamaha chips that are supported by the app. Please note that a lot of the parameters are a bit obscure if you are not versed in FM generation. The ultimate reference for these are the spec sheets, which are easy to find online. If you are new to FM, I would recommend starting with the generic FM generator as it tries to streamline the concept of FM a bit more. 

The emulation is done using [ymfm](https://github.com/aaronsgiles/ymfm) which is a fantastic library that emulates pretty much all of the Yamaha chips, please check out their work. 

As mentionned in the intro of this page, emulation accuracy is not perfect in KiraStudio, nor is it trying to be. Here are some inaccuracies that you will encounter compared to the real hardware:

* Each note runs its own little Yamaha chip with a single channel enabled. This mean that things are are supposed to be shared accross multiple channels, like LFOs for tremolo/vibratos, are not. So these may go out of sync in KiraStudio, while would not on the real hardware. This may be improved in the future.

* For the same reason, some of the specific DAC effects present on some chips are not emulated.

## ![](images/GeneratorFM2Op.png#header) YM2413 FM (OPLL)

xxx

## ![](images/GeneratorFM4Op.png#header) YM2612 FM (OPN2)

xxx

## ![](images/GeneratorFM2Op.png#header) YM3812 FM (OPL2)

xxx

## ![](images/GeneratorFM2Op.png#header) YM262F FM (OPL3)

xxx

## ![](images/GeneratorSquare.png#header) YM2149 SSG

xxx

## ![](images/GeneratorSample.png#header) YM2610 Sample (OPNA)

xxx

# Famicom/NES Generators

This section will cover the various Famicom/NES generators and their parameters. 

## ![](images/GeneratorSquare.png#header) NES Square

xxx

## ![](images/GeneratorTriangle.png#header) NES Triangle

xxx

## ![](images/GeneratorNoise.png#header) NES Noise

xxx

## ![](images/GeneratorSample.png#header) NES 1-Bit DPCM

xxx

## ![](images/GeneratorSample.png#header) NES 7-Bit PCM

xxx

## ![](images/GeneratorWaveTable.png#header) NES Famicom Disk System

xxx

## ![](images/GeneratorSquare.png#header) NES VRC6 Square

xxx

## ![](images/GeneratorSaw.png#header) NES VRC6 Saw

xxx

## ![](images/GeneratorFM2Op.png#header) NES VRC7

xxx

## ![](images/GeneratorSquare.png#header) NES Sunsoft 5B

xxx

## ![](images/GeneratorWaveTable.png#header) NES Namco 163

xxx

# Game Boy Generators

## ![](images/GeneratorSquare.png#header) Game Boy Square

xxx

## ![](images/GeneratorNoise.png#header) Game Boy Noise

xxx

## ![](images/GeneratorWaveTabel.png#header) Game Boy Wave

xxx
