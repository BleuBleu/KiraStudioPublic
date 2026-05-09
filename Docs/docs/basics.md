# Controls

## Basic Desktop Controls

Most operations are performed with the mouse. In general:

* The **Left mouse button** adds and removes stuff. 
    * **Single-clicking** adds notes/patterns.
    * **Double-clicking** deletes notes/patterns.
* The **Right mouse button** opens context menus and selects things.
    * **Right-clicking** quickly will open a context menu.
    * **Right-clicking + holding and dragging** will select a range of notes or patterns in the piano roll or sequencer.
* The **Middle mouse button** is used for navigation:
    * **Middle-clicking + holding and dragging** will pan the viewport.
    * **Rotating the mouse wheel** will zoom the viewport in/out.

If you are working on a trackpad, please check out how to enable [Trackpad controls](config.md#input) in the configuration dialog.

## Basic Mobile Controls

On mobile, there are 4 main gestures used:

* A **Quick Tap** will usually add stuff such as pattern, notes or vertices on a curve. 
* A **Swipe** will pan the viewport around.
* A **Pinch** will zoom the viewport in/out.
* A **Long Press** on something will reveal advanced options or start a rectangular selection. In some cases where multiple actions are available (ex: selection + contextual menu), a pulsing circle will appears to give you a choice.

# Main Window

The main window is composed of a few main controls:

* The **Toolbar** contains shortcuts to various common functions such as undo/redo, copy/paste, etc. 

* The **[Sequencer](sequencer.md)** (or Pattern Editor) is where you add or remove channels & tracks. It is also where you organize patterns, which are reusable little snippets of music that form the high-level structure of your songs. On mobile, this is your home base and where you always return to when you close every other view. 

* Below the Sequencer are various views such as the **[Piano Roll](pianoroll.md)**, **[Automation Track Editor](autotrack.md)**, various **[Curve Editors](envelopes.md)** and so on. On mobile, these views are full-screen and can be opened and closed as needed. 

* The right-side panel is the **[Project Explorer](instruments.md)**. This panel allows for navigating through the various objects in your projects (songs, instruments, effects, etc). It also enables the editing and automating of parameters for these objects. On mobile, this panel retracts and can be opened by either pressing the **Project** button in the toolbar or by double-tapping a channel in the Sequencer. 

* The **Pop-up Piano** is at the very bottom. This piano allows the previewing of instruments associated with the **Active Channel**, which is the highlighted channel in the Sequencer. This piano can be toggled using the **Piano** button in the toolbar.

<!--
- TODO : Tablet screenshot + crop titlebar + write name of things on images.
-->

=== "Desktop"
    ![](images/MainWindowDesktop.png#center)
=== "Phone"
    ![](images/MainWindowMobile.png#center)
=== "Tablet"
    ![](images/MainWindowMobile.png#center)

<!--
- TODO : Mention text editing on desktop somewhere.
- TODO : Talk about sliders here, desktop + mobile
- TODO : Undo redo, autosaves, etc.
-->