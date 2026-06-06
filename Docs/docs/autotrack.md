# Automation Track Editor

The **Automation Track Editor** is where you edit vertices of automation tracks. Automation tracks are special tracks that control the value of a single parameter over the course of a song. The controlled parameter typically belongs to an instrument or an effect of the parent channel.

To learn how to create an automation track for a given parameter, please refer to [this section](projectexplorer.md#automating-parameters).

The automation track editor is made of a few components:

* On the left is the **Scale**, which shows the horizontal grid values.
* On the top is the **Timeline**, which displays the beats in a `Bar.Beat` format and the pattern names/colors.
* In the middle is the editor itself where curves are edited, and...
* In the top-right corner is the **Floating Toolbar**, which contains various snapping and view options.

![](images/AutomationEditor.png#center)

# Editing automation curves

This next section will focus on curve editing. 

Curves are either smooth (interpolated) or discrete (uninterpolated). Uninterpolated curves will switch values abruptly, which may be desirable for some types of parameters. As of version 1.0, there is no way to mix smooth and non-smooth segments. 

As seen in the image above, vertices belonging to the same pattern will be connected by a solid line, while vertices between different patterns won't show a line. This is simply a visual cue to help you differentiate the lines you have intentionally drawn, and the ones the app is implicitly adding between patterns.

## Adding and deleting vertices

Adding vertices is done with a single click. On desktop, you can keep holding the mouse button to fine-tune its position until you release. 

Deleting a single vertex can be done by double-clicking. To delete an entire selection, simply press **Del** on desktop, or use the **Delete (X)** button on the toolbar on mobile.

## Selecting vertices

Selected vertices appear white and can be modified as a group.

* On desktop, you can select vertices by right-clicking in the background and dragging to draw a rectangle. You can add to the existing selecting by holding **Ctrl** while performing a selection.
* On mobile, you can long-press in the background and start drawing a rectangle once the pulsating circle appears. 

You can also select a time range of vertices by doing a selection from the timeline, which is the row with the bar/beat numbers at the top.

This is very similar to how selection works in the [piano roll](pianoroll.md#selecting-notes). 

## Moving vertices

To move vertices, simply click and drag. If multiple vertecies are selected, all the selected vertices will move together.

On desktop, you can also move vertices using the arrow keys. Pressing up/down will move them by 1 major grid increment. Pressing left/right will move by the amount of snapping precision currently selected.

## Duplicating vertices (desktop only)

While dragging vertices, you can duplicate the current selection by pressing and holding **Ctrl**. 

## Copy and pasting vertices

This behaves exactly like the [piano roll](pianoroll.md#copy-and-pasting-notes).

## Snapping to beats

This behaves exactly like the [piano roll](pianoroll.md#snapping-to-beats).

## Changing the zoom level

This behaves almost exactly like the [piano roll](pianoroll.md#changing-the-zoom-level). The only difference is that to zoom vertically, you need to scroll using the mouse wheel (or pinch using trackpad controls) on the scale to the left.
