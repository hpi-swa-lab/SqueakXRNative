Project current addDeferredUIMessage: [[
  Transcript showln: 'Installing updates'.
  MCMcmUpdater updateFromServer.

  Transcript showln: 'Installing Tonel'.
  Metacello new
    repository: 'github://squeak-smalltalk/squeak-tonel:squeak';
    baseline: 'Tonel';
    load.

  Transcript showln: 'Installing SqueakXR'.
  Metacello new
    baseline: 'SqueakXR';
    repository: 'github://hpi-swa-lab/SqueakXRNative:main/squeak';
    load.

  Workspace new
    buildAndOpen;
    contents:
'"Use this to start a 3D world."
world := SRWorld new.
world start.

"Use this to stop the running 3d world.
You can also use the stop button in the SRWorld project"
world stop.'.

  Transcript showln: 'Image is prepared!!'.
  Smalltalk snapshot: true andQuit: true.
] on: Error do: [:e |
    Transcript
      showln: 'An error occurred while preparing the image:';
      showln: e description.
      Smalltalk snapshot: false andQuit: true withExitCode: 111 embedded: false.
  ]
  on: ProvideAnswerNotification do: [:n |
    Transcript
      showln: 'Got ProvideAnswerNotification (will resume with true):';
      showln: n description.
    n resume: true.
  ]].
