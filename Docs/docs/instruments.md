# Project Explorer

The **Project Explorer** allows editing the various parameters of the objects in your projects: songs, instruments, generators, effects, samples, etc. 

This section will try to break down each major type of object, explain their various parameters and show how most of them can be **automated** (i.e. controller) in various ways.

![](images/ProjectExplorer.png#center)

On mobile the project explorer is not always visible, and slides from the right side on demand by pressing the **Project** button from the toolbar. A much quicker way to open it and navigate directly to a channel is to double-tap on a channel's name in the [sequencer](sequencer.md).

![](images/OpenProjectExplorerMobile.gif#center)

The project explorer displays parameters in sections that can be expanded and collapsed. Some sections will be collapsed by default, and will need to be expanded to reveal the parameters, especially on mobile where vertical space is limited.

## Project structure

At the very top of the project explorer is the **Navigation bar**. Much like the folder hierarchy on a computer, it shows the path of the current object in your project. 

In the example below, the "Bitcrushed Drum 1" channel is contained in the "Ruder Buster" song, which is itself part of the "Deltarune" project. Each portion of the path is clickable and will bring you to that specific object.

![](images/NavBar.png#center)

The general structure of a project in KiraStudio is:

- A project contains one or more song(s)
	- Each song contains a series of channel(s)
		- Each channel (which may any of the [3 types](sequencer.md)) may contain effect(s). 
- A project also contains zero or more instrument(s)
	- Each instruments is made of generator(s)
- A project also contains zero or more samples(s)

# Editing songs

When creating a new project it will already contain a song by default, but it can contain more. To create a new song, navigate back to the root of your project and click the **(+) Add Song** button. Clicking on a song will show its properties and will make it the active one inside the app.

![](images/SongParameters.png#center)

Songs have very few parameters. Besides their name and colors, which can be customized, they mostly just have a duration (in bars) and a default time signature. The default time signature is the main time signature that will be used in bars without a [custom time signature](#custom-time-signatures).

Also displayed along with the song parameters the the list of channels. Clicking a channel will navigate to its parameters, exactly as if you had clicked on the channel name in the [sequencer](sequencer.md).

# Editing channels

Channels are the main type of objects you will be looking at in the project explorer. 

There are [3 types of channels](sequencer.md) in KiraStudio, which we will explore in the following sections.

## Effect chains

Effect chains are simple channels that can contain a series of effects (reverb, filters, etc). Instrument channels can send their outputs to these effect chains and they can cascade, ultimately ending at the Master channel. 

Please note that unlike traditional DAWs, audio is always sent fully to a single effect chain. As of version 1.0, it is not possible to only partially send audio to a chain, or to send to more than one chain.

![](images/EffectChainParameters.png#center)

Besides their name/color, effect chains have 3 unique parameters:

- **Volume** : Basic volume adjustment.
- **Balance** : Stereo balance adjustment.
- **Effect Send** : The effect chain to send this channel's audio to.

A much more efficient way of adjusting the volume, balance and effect send of a channel is to use the [mixer view of the sequencer](sequencer.md#mixer-view).

Effects are applied one at a time, in a top-to-bottom order, but the channel volume and balance are applied at the end, after all effects of the channel have been applied. To alter the volume or balance prior to, or between 2 effects, a dedicated **Volume** and **Pan/Balance** effect exists.

Effects can be added by pressing the **(+) Add Effect** button below the last effect, and can be deleted by right-clicking (or long-pressing on mobile) on a specific effect and selecting the delete option.

<!--
> TODO : Link to volume + balance effect.
> TODO : Link effect reference here. 
-->

## Master channel

The master channel is a special type of effect chain. There is always one in a song, it is always the final effect chain, and it can never be deleted.

![](images/MasterChannelParameters.png#center)

Besides the standard effect chain parameters, the master channel has 2 unique parameters:

- **BPM** : The main BPM of the song. This value can be automated to create tempo variations.
- **Final DC Removal Frequency (Hz)** : There is a very slight high-pass filter applied on the final output to remove any DC component. Some channels will have their own DC removal feature, but this one is present to avoid clipping when combining asymmetric waveforms. 

The master channel may also contain effect(s), and it works the same way as effect chains. Placing effects on the master channel is actually quite efficient, as this will ensure they are only applied once and keep the CPU usage low. 

## Instrument channels

Instrument channels are the most complex type of channel. They feature all the same parameters as effect chains, but also reference an instrument.

Is it important to understand that instrument channels **reference** (i.e. use) an instrument present in your project, which can be used by several channels at once. For convenience, when displaying the parameters of an instrument channel, KiraStudio will also show you the parameters of that instrument in the channel. Channels have their own name/color, independent of the name/color of the instrument.

For example, in the image below, the "Bitcrushed Drums 1" channel is purple and uses the instrument "GS ROOM", which is yellow. We are effectively looking at 2 objects: an instrument at the top and a channel at the bottom. This order is to emphasise that effects are applied *after* generating the audio of the instrument.

![](images/InstrumentChannelParameters.png#center)

Besides the standard effect chain parameters, instrument channels have a single unique parameter:

- **Instrument** : This allows changing the instrument used by the channel. Clicking this will allow choosing a different one, or create a new one from scratch.

# Editing instruments

Instruments in KiraStudio are composed of **Generators**. A generator is a small unit able to produce an audio signal. They range from very basic oscillators, such as sawtooth and square waves, all the way to complex things like SoundFonts. 

This section will only explain the general principles, a comprehensive [generator reference](generators.md) is also provided.

Most instruments will only contain a single generator, but combining them can yield interesting effects. In the example below, a lead instrument is created by adding a pulse-modulated square waveform and a sawtooth waveform.

![](images/InstrumentParameters.png#center)

Generators are combined in a top-to-bottom order. When adding generators this is not very important, but when using different **Blend Modes**, this becomes important.

Generators can be added by pressing the **(+) Add Generator** button below the last generator, and can be deleted by right-clicking (or long-pressing on mobile) on a specific generator and selecting the delete option.

Similarly, samples can be imported by pressing the **(+) Add Sample(s)** button below the list of generators.

As mentioned in the previous section, instruments can be edited through a channel using the instrument. They can also be edited on their own, by navigating to the root of the project and clicking an instrument. Both achieve the same result, the only difference being that some forms of automation, namely automation tracks and note parameters, can only exist when an instrument is used as part of a channel. In other words, the same instrument used by 2 different channels may have different parameters automated. This will be covered in sections that will be added soon.

<!--
> TODO : Add the Automating parameters section, and when they are added change the last sentence from "This will be covered in sections that will be added soon" to "This will be covered in the following sections".

# Automating parameters
-->

<!--
> Mention that auto track + per note slides can still be changed, for preview purpose.
-->
