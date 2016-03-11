# Pitch-Perfect

iPhone app that records your voice and then modulates the recorded audio to sound like a Chipmunk or Darth Vader. This app also lets you speed up or slow down the rate of playback.


#Record Sounds View

The record sounds view is the initial view for the app, and consists of a button with a microphone image. A label indicating the user to tap the button to start recording should be added beneath the image (not pictured).
Tapping this microphone button will start an audio recording session. The app will use code from AVFoundation to record sounds from the microphone.

Tapping the button will disable the record button, display a “recording” label, and present a stop button. For extra credit, present the user the ability to pause and restart recordings in addition to stopping them.


When the stop button is clicked, the app should complete its recording and then push the second scene (described below under “Play Sounds View”) onto the navigation stack.


The title in the navigation bar should be “Record”.


#Play Sounds View

The play sounds view has four buttons to play the recorded sound file and a button to stop the playback.
The buttons for playing the recorded sounds will have images corresponding to their sound effect:
     Chipmunk image → High-pitched sound
     Darth Vader image →  Low-pitched sound
     Snail image → Slow sound
     Rabbit image → Fast sound
