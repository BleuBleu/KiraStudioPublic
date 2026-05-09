# Piano Roll

The **Piano Roll** is where you enter notes inside of patterns, and likely where you will be spending most of your time in the app.

The piano roll is made of a few components:

* On the left is the **Vertical Piano**, which can be used to preview the instrument of the selected channel. Note that the selected channel may not necessarily be the one being edited.
* On the top is the **Timeline**, which display the beats in a `Bar.Beat` format along with the pattern names/colors.
* In the middle is the piano roll itself where notes are edited.
* In the top-right corner is the **Floating Toolbar**, which contains various snapping and view options.
* At the bottom is the **Note Parameter Editor**, where extra note parameters (velocity, pan, aftertouch, etc.) can be edited. This panel can be revealed by using the option on the floating toolbar.

![](images/PianoRoll.png#center)

Unlike other apps like FL Studio, the piano roll does not only show you the notes of the current pattern in a vacuum, it displays a continuous view of a track. Notes can be freely moved from one pattern to another. Notes can extend far beyond the end of a pattern, but ultimately they belong to the pattern where they start from.

# Editing Notes

We will focus our attention to the center of the piano roll where all the notes lie.

## Adding and deleting notes

To add a new note, simply click on an empty space.

On desktop, you can choose between 2 editing modes in the floating toolbar. Both will create a note of the last duration used, they only differ on what happens when you move afterwards, while still holding the mouse button.

* **Click & Move** : Moving after the initial click will allow you to reposition the note.
* **Click & Resize** : Moving after the initial click will allow you to change the duration of the note.

On all platforms, deleting single notes is achieved by double-clicking. **Shift-Click** is also an alternate option on desktop.

## Selecting notes

Selected notes have a white outline around them and can be modified as a group.

* On desktop, you can select notes by right-clicking in the background and dragging to draw a rectangle. You can also add to the existing selecting by holding **Ctrl** while performing a selection.
* On mobile, you can long-press in the background and start drawing a rectangle once the pulsating circle appears. 



You can also select a time range of notes by doing a selection from the timeline, which is the row with the bar/beat numbers at the top.

<!--
> TODO : Animated GIF, desktop/mobile.
-->

## Moving, transposing and resizing notes

To move notes, simply click and drag. When starting a drag from a selected note, all the selected notes will move together.

* On desktop, notes can be resized by grabbing their left or right side edge and dragging. Desktop can also move notes using the arrow keys. Pressing up/down will transpose by 1 semitone, or 1 octave if **Ctrl** is held at the same time. Pressing left/right will move by the amount of the currently selected snapping precision.
* On mobile, notes are resized by using one of the big colored resize handles.

## Duplicating notes

When there is more than 1 note selected, the entire selection can be duplicated by dragging from the **Colored Paperstack Icon** and releasing it where you want to create the copy. On desktop, the same can also be accomplished by pressing and holding **Ctrl** while dragging notes.

=== "Desktop"
    ![](images/DuplicateNotesDesktop.gif#center)
=== "Mobile"
    ![](images/DuplicateNotesMobile.gif#center)

## Copy and pasting notes

An alternative way of duplicating notes is to use copy & paste. This provides more flexibility, as it allows copy and pasting notes between tracks.

1. Copy notes to the clipboard by making a selection and pressing **Ctrl+C**, or by using the toolbar button.
2. Position the playhead at the desired location.
3. Paste the stored notes using **Ctrl+V**, or by using the toolbar button on mobile.

## Snapping to beats

Snapping to beats (i.e. vertical grid) can be toggled from the floating toolbar on the right, and the precision can be adjusted. 

The snapping precision is expressed in beats. This mean that using a 4/4 time signature, for example, snapping to 1/4 Beat snaps to 1/16th notes.

## Changing the zoom level

On desktop, like in most views of the app, zooming horizontally is done using the mouse wheel, or a pinch gesture when using [trackpad controls](config.md#input). To zoom in vertically, simply use the mousewheel (or pinch on trackpad) on the vertical piano on the left. 

On mobile, all zooming is done with a pinch gesture. 

## Slide notes

Slide notes are notes that start at a given pitch (the pitch of the note) and slowly change to hit a target pitch, which is represented by where the triangle ends.

![](images/SlideNotes.png#center)

To create a slide note, simply select one of the 3 slide note modes from the contextual menu that appears when right-clicking (long-pressing on mobile) on a note. An alternative on desktop is to hold the **S** key, click on a note and drag up/down, which will start the creation of a slide note.

There are 3 types of slide notes:

* **Note Linear** : This is roughly the equivalent of doing a glissando on a piano. The note value itself (ex: A4 to A5) will be interpolated, leading to a natural-sounding slide. Unless you are trying to achieve a specific retro or chiptune effect, use this mode.
* **Frequency Linear** : This will interpolate the frequency of the note (ex: 440Hz to 880Hz) and use the result as the final frequency. 
* **Period Linear** : This will interpolate the period (ex: 1/440Hz to 1/880Hz) and use this as the final frequency. This mode is particularly useful for mimicking the behavior of retro/chiptune slides.

The frequency and period linear modes will display a convex or concave slide note. Please note that this is simply a rough visual cue and does not accurately represent the pitch of the note that will actually play. 

The target and duration of a slide note can be modified by dragging the **Four-Arrows Icon** that will appear if a slide note is present. 

* When using the [note end release mode](#release-modes), slide notes can extend beyond the release of the note, as sound can still be heard during the release. 
* When using the [manual release mode](#release-modes), slide notes will be required to end exactly at the end of the note, as this represent a hard-kill.

## Disabling attack

By default notes have an attack, which means they will restart their envelopes from the beginning. 

The attack can be toggled for a particular note by selecting the **Toggle Note Attack** option from the contextual menu that appears when right-clicking (long-pressing on mobile). 

Notes with no attack will show an ellipsis (...) before their value. This can be seen in the image above, where the note following a slide note has its attack disabled to create a single, long, gliding note.

Disabling the attack in the piano roll does not guarantee it will always work. In general, you should try to keep the note without attack in close proximity to the end of another note. Failure to do so may result in the attack still playing.

Here is a more technical breakdown of how it all works: When the player encounter a note without attack, it will look for a previous note still producing sound that can be continued by the note without attack.

1. If the note without attack is **immediately** after the end of an existing note, it will continue it.
2. If the note without attack is shortly after the end of an existing note, while its release is still playing, it will continue it and stay in the release state.

If there are multiple candidate notes, it will take the one with the closest matching pitch. This test will consider slides in this calculation (ex: a note without attack being near the end of a slide notes).

## Arpeggio chords

**Arpeggio Chords** take the notes of a chord and arpeggiate it rapidly, in a pre-defined sequence. This option is mostly there to mimic a trick often used in chiptune songs, where composers would play notes of a chords in quick succession to make up for the lack of polyphony on old hardware.

To enable arpeggio chords, simply select the notes of a chord, right-click on any selected note (long-press on mobile) and select **Toggle Selection Arpeggio Chords** from the contextual menu. Visually, notes with arpeggio chords enabled will be drawn with a stripe pattern.

![](images/ArpeggioChord.png#center)

The speed and order in which individual notes of an arpeggio is played is controlled in the channel settings, under the **Arpeggio** tab.

![](images/ArpeggioSettings.png#center)

<!--
> TODO : Do we explain the settings here? Or in PE page?
-->

## Release modes

<!--
> TODO : Explain both modes, with images.
-->

## Ghost notes

**Ghost Notes** are a visual tool allowing you to see a semi-transparent version of the notes of a channel while editing another. This can be useful to align notes across several channels. 

![](images/GhostNotes.png#center)

You can select which other channels you want to see as ghost notes by checking them in the menu from the floating toolbar.

## Scales

By default, the piano roll highlights the white and black keys, which is the C major scale. You can change the type of scale as well as the root note from the floating toolbar. This setting is per-track, so different tracks may choose to highligt different scales.

As of 1.x, the app supports the following scales: Major (Ionian), Natural Minor (Aeolian), Harmonic Minor, Melodic Minor (Jazz Minor, Dorian, Phrygian, Lydian, Mixolydian, Major Pentatonic, Minor Pentatonic, Blues and Whole Tone.

# Note Parameters 

The note parameter editor can be opening using the option in the floating toolbar. This panel allows you to edit additional properties of notes, such as note velocity, stereo panning, etc.

![](images/NoteParamEditor.png#center)

This editor only shows one parameter at a given time, and can be chosen by using the option in the floating toolbar.

## Editing note parameters

Editing note parameters is as simple as clicking and dragging to paint the values. If notes are currently selected, only the selected notes can be edited. 

## Snapping

You can snap the painted values to the major grid by enabling the **Parameter Values** option in the Snap section of the floating toolbar.

## Changing the zoom level

On desktop, you can zoom vertically to get more precision when editing note parameters. Simply use the mousewheel (or pinch on trackpad) on the scale to the left of the parameter editor. 

## Note parameter curves

Some parameters, such as Velocity, only support a single constant value for each note. Others may support having their value change during the playback of a note. 

The type of value for a given note parameter can be changed through the **Value Type** option of the floating toolbar while one or more notes are selected. If the option is greyed out, it means the parameter does not support curves.

* **Constant** : a single value that remains constant.
* **Curve** : a value that can change abrutly.
* **Curve (Interpolated)** : a value that changes smoothly

Once a note is set to either curve modes, you can edit its curve by enabling the **Curve Edit Mode** from the floating toolbar.

When curve edit mode is active, a single-click on the curve will add a new vertex, and double-click with delete and existing one.  The first and last vertex cannot be deleted and the last vertex is currently required to be at the end of the note duration. 

Vertices can be moved by dragging and will respect any snapping setting.

![](images/NoteParamCurve.gif#center)

When multiple notes are selected, any modification to a curve will cause all other selected notes' curves to become identical to the one being editing.
