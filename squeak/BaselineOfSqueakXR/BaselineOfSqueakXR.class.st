Class {
	#name : #BaselineOfSqueakXR,
	#superclass : #BaselineOf,
	#category : #BaselineOfSqueakXR
}

{
	#category : #baseline,
	#'squeak_changestamp' : 'lege 5/5/2026 11:27'
}
BaselineOfSqueakXR >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			project: 'FFI' with: [
				spec
					className: 'ConfigurationOfFFI';
					repository: 'http://www.squeaksource.com/MetacelloRepository';
					versionString: #development;
					loads: #('Core')];
			baseline: '3DTransform'
				with: [spec repository: 'github://hpi-swa-lab/squeak-graphics-opengl:main/3DTransform/src/'];
			baseline: 'OSProcess'
				with: [spec preLoad: #loadOSProcess];
			"baseline: 'CommandShell'
				with: [spec repository: '???'];"
			baseline: 'GitS'
				with: [spec repository: 'github://hpi-swa/git-s:latest-release/src'].
		
		spec
			package: 'OpenXR';
			package: 'OpenAL';
			package: 'Raylib';
			package: 'SqueakXR' with: [
				spec
					requires: #('OpenXR' 'OpenAL' 'Raylib' 'FFI' '3DTransform' 'OSProcess');
					postLoadDoIt: #postLoad].
		
		spec group: 'default' with: #('SqueakXR')]
]

{
	#category : #baseline,
	#'squeak_changestamp' : 'lege 5/5/2026 11:27'
}
BaselineOfSqueakXR >> loadOSProcess [

	PreferenceWizardMorph new installOSProcess
]

{
	#category : #'post-load',
	#'squeak_changestamp' : 'lege 4/30/2026 18:09'
}
BaselineOfSqueakXR >> postLoad [

	self error: 'make sure that transpile only runs when necessary tools are present'.
	SRShader transpileAll.
]
