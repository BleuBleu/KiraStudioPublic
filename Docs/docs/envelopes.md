# Envelopes

Curves are one way to automate (i.e. control) the value of parameters on a generator, effect or channel. Curves are best suited to automate short or repetitive variations, such as the attack of an instrument, or a simple tremolo/vibrato. 

There are 3 main types of curves in KiraStudio:

- **ADSR Envelope** : ADSR refers to Attack, Decay, Sustain & Release. These types of envelopes are very standard in synthetizers, and go through a set of well-defined phases. They are well-suited to shape how the amplitude of a sound changes gradually over time but may also be used to affect other things, such the frequency of a filter during the attack of a note, for example.

- **Custom Curve** : Custom curves in KiraStudio can reproduce most of what ADSR envelopes do, but are much more flexible. They can have an arbitrary number of vertices, segments can have different curvatures, and custom loop and release points can be set. They are also able to sync to the beat of the song better than ADSR. You may use custom curves as a substitute for ADSR envelopes, but they are generally better suited for things like tremolos and vibratos. When used that way, they are often referred to as LFOs (low-frequency oscillators) in other music applications. 

- **Sequence** : Sequences are a discrete series of numbers, represented as a bar graph. They mostly exist to give more granular control over the values, when running at low update rates and trying to reproduce the behavior of retro consoles (e.g. to sound like a console that ran at 60Hz). For this reason, the speed at which they they advance is intimately tied to the [update rate](instruments.md) of your project.

<!--
> TODO : Make sure this points to the right place.
-->

Not every parameter will offer you all 3 types of curves, instead attempting to offer you a selection that makes sense for that type of parameter.

# Common

All 3 curve editors are quite similar. This section will try explain features that are common to more than one editor, while the following sections will look into the features that are more unique to each.

All editor features the same components:

- On the left side is the **Scale**. It shows the range of possible values and the major/minor grid.
- On the top is the **Timeline**, which displays the time in various units (seconds, beats, etc.) depending on the context.
- On the right is the **Floating toolbar**, and contains various parameters related to the curve being edited, and...
- In the center is the **Viewport**, which is the main editing area.

## Adjusting the zoom level

Like any most views in the app:

- On Desktop, you can zoom in and out horizontally by using the mouse wheel. To zoom vertically, you do the same, but on the left-side scale. 
- On Mobile, you can simply pinch to zoom.

## Presets

All envelope editors feature various presets, which can be set and adjusted in the floating toolbar on the right. 

- The ADSR presets are loosely based on [this video](https://www.youtube.com/watch?v=9niampRkFW0). This is a great resource to understand how ADSR works and how real instruments behave.
- For custom curves and sequences, these presets can be adjusted to a minimum/maximum range. For example, to create a simple vibrato, choose the sine preset and adjust to the desired range.

## Snapping

All editors support snapping to parameter values (Y-axis). The custom curve editor also supports snapping in the time direction (X-axis) with a configurable grid. Snapping is togglable from the floating toolbar.

## Loop and release points

Curve curves and sequences allow you to place a loop and release point. 

- The **Release point** is where the playhead will jump to when the note is released. If no loop point is present, the playhead will stop at the release point, and maintain that value until the note is released.
- The **Loop point** is where the playhead will jump to when it hits either the release point if one if present, or the end of the curve if no release points are present.

## Sync/Trigger modes

Curve curves and sequences can run in 2 modes : **Sync** or **Trigger**. 

- **Trigger** : The curve starts from the beginning when a new note attack is triggered. This mode can only be used on generator parameters. 
- **Sync** : The curve starts from the beginning of the song and repeats indefinitely. This mode comes with limitations, such as not being able to set custom loop/release points or delays. Sync curves are assumed to constantly loop from the beginning.

For parameters that are not on a generator (e.g. on an effect or a channel) the app will force you to use Sync mode, since there is no notion of notes being triggered in this context.

## Copy & pasting

Copy and pasting support varies a bit depending the type of curve:

- For ADSR envelopes and custom curves, you can only copy and paste the entire curve at once. As of version 1.0, there is no selection in these editors.
- For sequences, there is proper selection and copy/paste support, but unlike other views, pasting will happen at the first selected value.

# ADSR Envelope Editor

The ADSR envelope editor is very straightforward. You can either change the values in milliseconds/seconds in the floating toolbar, or move the vertices in the viewport. The curvature of individual segments can only be changed in the viewport.

The curve is always made of 5 vertices, but very often the attack and hold vertices are on top of each other and edited as one, when the hold time is zero. We have been refering to this type of curve as ADSR envelopes, but it is technically a AHDSR envelope, where H stands for Hold. 

![](images/ADSR.png#center)

Please note that the curve is a only visual representation. The actual amplitude that will be played depends on various factors, such as the amplitude reached at the moment the note was released. Previewing notes using the pop-up piano or a MIDI keyboard will show you the true behavior of the envelope.

# Custom curve editor

The custom curve editor works similarly to the ADSR envelope editor, but is much more sophisticated. 

![](images/CustomCurve.png#center)

## Adding/deleting vertices

To add new vertices, simply click in an empty space, away from any existing vertex. Deleting vertices is done by double-clicking.

## Paint Mode 

Paint-Mode can be activated from the floating toolbar. It can be a quick way to draw very complex curves. 

Select a shape to paint and draw in the viewport. The painting will be aligned to the X-axis grid. For shapes with varying values (saw, triangle, etc) a **Base Value** can be specified and be the minimum value for the painting, the maximum one being where your cursor will draw. 

The **Step** preset is particularly useful to create curves changing in discrete steps. 

![](images/CurvePaintMode.gif#center)

## Scale release

The **Scale Release** option will be available when using a custom curve for volume-like parameters. This setting will affect the behavior of the release to make it work more like a typical ADSR envelope. 

More specifically, it will rescale the release part of your curve, at run-time, depending of the value at the time the note was released.

For example, if the note was released while the curve had a value of 50%, the entire release will be rescaled to make it start from 50%. This prevents audio popping that would be caused by a sudden amplitude change, and sound much more natural.

# Sequence Editor

The sequence editor is mostly aimed at replicating the sound of chiptune, where values would often change in dicrete steps at very specific intervals, such at once per frame at 60 FPS. 

Each step on the X-axis represents the value for 1 **Frame**. The duration of a frame is derived from the **Advance Rate** and the [**Project Update Rate**](instruments.md). The advance rate is an interval of the project update rate.

For example:

- If your project update rate is 1500 Hz (the default) and the advance rate is 25, each column represents 1/60th of a second (25 / 1500). 
- If your project update rate is 60 Hz (good for chiptune) and the advance rate is 1, each column also represents 1/60th of a second (1 / 60).

<!--
> TODO : Link to where we discuss project settings.
-->

![](images/Sequence.png#center)

## Drawing values

Drawing is slightly different on desktop and mobile:

- On desktop, click and mouse the mouse in the viewport to draw.
- On mobile, long-press in the viewport, wait for the pulsating circle, then start drawing.

## Selecting values

To select:

- On desktop, right-click and move the mouse in the viewport or the timeline.
- On mobile, selection is done by long-pressing in the timeline, waiting for the pulsating circle, then making the selection.

## Changing values

Once you have a selection, values can be edited as a group. The **Scale Mode** can also be changed in the floating toolbar to switch between **Absolute** and **Relative** scaling, the former simply offsetting values and the latter trying to preserve the shape of the selection. 

![](images/SequenceEditValues.gif#center)

# Advanced topics 

## Dynamics

Depending on the type of curve and parameter being automated, the **Dynamics** section of the floating toolbar may contain some graphs that allow you to change the scale (i.e. intensity) or rate (i.e. speed) at which a curve is played. 

![](images/Dynamics.gif#center)

For example, the ADSR envelopes on the "Envelope" parameter of most generators will show the 4 graphs:

- Velocity (X) vs. Scale (Y) : How the velocity note parameter in the piano roll affects the scale/intensity of the curve. By default there is a 1:1 relationship, so the velocity essentially acts like a volume control.
- Velocity (X) vs. Rate (Y) : How the velocity note parameter in the piano roll affects the rate/speed of the curve. By default there is no impact on the speed, but this allows curves to be played slower/faster depending on the velocity.
- Key (X) vs. Scale (Y) : How the note being played (e.g. C4) affects the scale/intensity of the curve. By default this has no effect, but can be made to play curves more/less intensively depending on the note. This is sometimes called "key scale level".
- Key (X) vs. Rate (Y) : How the note being played (e.g. C4) affects the rate/speed of the curve. By default there is no impact on the speed, but can be made to play curve slower/faster depending on the note. This is sometimes called "key scale rate".

In some other situations, such as for non-envelope parameters, you will be able to control how the curve responds to **Aftertouch**. This is particularly useful to create ad-hoc vibrato or tremolo on some specific notes. By controlling the intensity of the curve through the aftertouch you can selectively change the aftertouch value of some notes, and only trigger the vibrato or tremolo at the desired time.

## Pinning 

On desktop, in the [project explorer](instruments.md), it is possible to **pin** a curve and see a small editor. This is intended to allow small adjustments of curves without having to open the full-fledged editor. 

To pin a curve, right-click on a parameter automated by a curve and select the pin option. Unpinning is done in a similar way.

![](images/Pin.gif#center)
