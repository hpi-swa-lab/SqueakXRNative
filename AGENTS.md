\# Working in the Squeak/Smalltalk Environment



Squeak/Smalltalk is a live programming environment, so code changes that you make are active immediately.

This is powerful, but means that appropriate care to preserve the system must be taken.



External files are mostly there for support and version control; otherwise, we use persistent image state that is not checked into version control.

Since we want to continue using the image, take care not to store unnecessary data in it.

Large assets, like 3D models with many vertices, should also be stored outside the image.



Strongly refrain from creating global variables (e.g. with Smalltalk>>at:put:).



\# Editing Smalltalk Code



When editing Smalltalk code, ALWAYS use the Squeak MCP interface.

If it is not available, refrain from making changes in Smalltalk code.

Instead, ask for the server to be started.



\# Style Rules for Smalltalk



* Always end lines with a period, unless it is the final return line.
* Always leave an empty between the message signature and the body of the method.
* Use as few comments as possible. Code should be self-documenting.

  * Comments must only be used in cases where something truly unusual is happening that is not obvious from the code, warranting explanation.
  * Under no circumstances use comments to describe what is happening in a method.
  * If you have to use comments, keep them as short as possible, leaving out superfluous context etc.
  * Keep class comments extremely short.
* Prefer small methods over large ones.
* Prefer multiple smaller classes over a single large one if splitting along boundaries of concern is feasible.
* Reuse code as much as possible, deduplicate liberally.
* Avoid singletons as much as possible. Minimize state on the class side.
* Use class methods for constants etc.
* Write tests only for behavior that it is concerned with

  * Bad: Checking if an object renders because it overwrites the renderOn: method (this is the job of SRObject)
* Tests must execute very quickly; do not write tests that are expensive to execute.
* Do not write tests that depend on state or behavior external the SqueakXR
* Use the unit method for numbers where applicable (m, cm, km, ...)



You must not write methods with variables that shadow instance or class variables.



\# SRWorld



There can only be one world running at a time.

However, you cannot assume that there is one running.

You may not start a world, but you may ask the user to do so.

You may also not stop a world without permission.

You may not switch between projects without permission.



\# Version Control



We use Git for non-Smalltalk files and GitS for Smalltalk code (a Squeak implementation of Git).

NEVER make a commit yourself.



\# Crashes and Errors



Try to avoid crashes and errors if feasible.

If an operation is necessary but there is a risk of the system crashing, entering an inconsistent state, etc., notify the user and allow them to save the image beforehand.



If Squeak crashes or the MCP server is no longer available, wait for the user to restart it.

