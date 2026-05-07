| show |

show := [:s | FileStream stdout nextPut: Character cr; nextPutAll: s; flush].

show value: 'Starting image preparation script'.

Project current addDeferredUIMessage: [[
  show value: 'Installing updates'.
  MCMcmUpdater updateFromServer.

  show value: 'Installing Tonel'.
  Metacello new
    repository: 'github://squeak-smalltalk/squeak-tonel:squeak';
    baseline: 'Tonel';
    load.

  show value: 'Installing SqueakXR'.
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

"Use this to stop the running 3D world.
You can also use the stop button in the SRWorld project"
world stop.'.

  show value: 'Image is prepared!!'.
  Smalltalk snapshot: true andQuit: true.
] on: Error do: [:e |
    show value: 'An error occurred while preparing the image: ', e description.
      Smalltalk snapshot: false andQuit: true withExitCode: 111 embedded: false.
  ]
  on: ProvideAnswerNotification do: [:n |
    show value: 'Got ProvideAnswerNotification (will resume with true): ', n description.
    n resume: true.
  ]].
