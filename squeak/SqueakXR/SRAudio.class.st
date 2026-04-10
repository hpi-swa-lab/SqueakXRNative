Class {
	#name : #SRAudio,
	#superclass : #Object,
	#instVars : [
		'device',
		'context'
	],
	#classVars : [
		'Instance'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/10/2026 16:19'
}
SRAudio class >> initialize [

	"Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self."
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/19/2025 16:55'
}
SRAudio class >> instance [

	^ Instance ifNil: [Instance := self basicNew initialize]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/8/2026 18:07'
}
SRAudio class >> resetInstance [

	Instance cleanup.
	Instance := nil
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/8/2026 18:00'
}
SRAudio class >> shutDown: quitting [

	quitting ifFalse: [^ self].
	self instance cleanup.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/8/2026 18:06'
}
SRAudio class >> startUp: resuming [

	resuming ifFalse: [^ self].
	self instance setup.
]

{
	#category : #'error checking',
	#'squeak_changestamp' : 'lege 1/8/2026 15:36'
}
SRAudio >> checkErrorAl [

	| code matches |
	code := OpenAL alGetError.
	code = AlDefines alNoError ifTrue: [^ self].
	code := code asString.
	matches := OrderedCollection new.
	AlDefines class methodsDo: [:m |
		((m getSource asString includesSubstring: code asString)
		and: [(m selector includesSubstring: 'alc') not]) ifTrue: [matches add: m selector]].
	self error: 'AL error: ', (matches joinSeparatedBy: '; ').
]

{
	#category : #'error checking',
	#'squeak_changestamp' : 'lege 1/8/2026 15:37'
}
SRAudio >> checkErrorAlc [

	| code matches |
	code := OpenAL alcGetErrorDevice: device.
	code = AlDefines alcNoError ifTrue: [^ self].
	code := code asString.
	matches := OrderedCollection new.
	AlDefines class methodsDo: [:m |
		((m getSource asString includesSubstring: code asString)
		and: [m selector includesSubstring: 'alc']) ifTrue: [matches add: m selector]].
	self error: 'ALC error: ', (matches joinSeparatedBy: '; ').
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/8/2026 18:05'
}
SRAudio >> cleanup [

	context ifNotNil: [
		OpenAL alcMakeContextCurrentContext: nil.
		OpenAL alcDestroyContext: context.
		context := nil].
	device ifNotNil: [
 		OpenAL alcCloseDevice: device.
		device := nil]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/19/2025 16:49'
}
SRAudio >> createAudioPlayer [

	^ SRAudioPlayer new
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/17/2025 11:40'
}
SRAudio >> createAudioStreamPlayer [

	| source buffer data |
	source := ExternalType uint32_t allocate.
	OpenAL alGenSourcesN: 1 sources: source.
	
	buffer := ExternalType uint32_t allocate.
	OpenAL alGenSourcesN: 1 sources: buffer.
	
	Transcript showln: 'source ', source.
	Transcript showln: 'buffer ', buffer.
	
	data := self data base64Decoded asByteArray.
	OpenAL alBufferDataBuffer: buffer format: 16r1101 data: data size: data size samplerate: 24000;
		alSourceQueueBuffersSource: source nb: 1 buffers: buffer;
		alSourcePlaySource: source.
	
	"OpenAL alDeleteSourcesN: 1 sources: source.
	OpenAL alDeleteBuffersN: 1 buffers: buffer."
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/16/2025 17:55'
}
SRAudio >> data [

	^ 'oAKQAmACIAHQAaABcAFQASAA8ADAAIAAUABQAGAAUABAAFAAYABQAFAAYABgAFAAQABAAEAAUABgAIAAYABQADAAIAAgAFAAcACgALAAoABgABAP7/9//v/+r/5P/e/9n/1P/M/8L/uv+y/6//rv+w/7P/s/+y/7T/t/+5/8D/y//X/+H/6v/0////CQAUACIAMAA8AEgAUgBZAFsAWgBc
AF4AXQBYAFMATQBJAEUAPgA0ACwAJgAgABgAEQAHAPj/5P/U/8b/uf+t/6L/m/+T/4z/jP+U/53/qf+6/8//5f/5/wYAFAArAEAAVwB1AI0AnwCmAK4AvgDMANMA0wDOAMQAqgCTAIQAdQBjAEsANAAbAP//7v/p/+f/4P/P/8L/v/+4/7r/v/+//8n/1v/Y/93/5P/l//H/AQABAP///f
/4////BQAGAPv/6f/h/9X/zv/Y/9//1//L/8X/xv/F/8P/v/+//8b/0P/V/83/z//a/+T/8v8BAAgAAAD7/wYAHAArABAA8P/z/w0AFgAFAPH/yv+g/6v/0f+//4P/hf+f/6X/zf+k/zf/Xf+h/6v/pv9X/xv/OP9d/0v/G/8K//7++/4q/z3/K/8c/x7/Sv87/xb/KP8i/0b/lv+g/6j/
z//N/83/+P8fAEMATwBNAFwAWgByAJcAfwBRAEEAWgCHAKQAlwCKAJEAkgCgAKIAigB2AGAAVwBaAEIAIQATAAwAFgAzAEEALAAsAFsAbwB6AKgAxwC6AKkAygD8ACEBOQFBAWEBcwFnAXsBmAGPAXgBcAFMASQBFgHZAKwAzQDMAKoAnAB7AE8AQQBUAG0ATwAlAC8ADwATAHUAYABNAI
QATQA3AG8AoAC0AIEAbgB6AGQAUgBEAEMALAAnACEAxv/A/8f/bf+G/6D/YP9h/0z/L/8+/xf/+f7w/tz+3f7o/uT+xf61/sL+0f7h/vT+HP9B/0j/Uf9X/1n/Xv9l/2v/Zf9o/1z/P/8m/wL/+v4W/yr/O/88/yD/Ff8o/xr/6v7F/rH+o/6W/qL+o/5k/i3+LP4o/iz+Qf5K/mD+ff6U
/rr+2f7q/hX/W/+W/8H/8/8sAEoAUwBnAH4AjgCeAKIArAC6AK8AmAB9AFgANAAhABkAEQATAA8AAAD9//j/AAAhACsAMABJAEUAQABFABsAEAAyACAADQA3AFMAXACLAJ4AkQDYAAEB0gASAXYBhQGqAdoBDQIeAvIB+AELAgoCHQIhAgYCvQFVAQUB6ADvANwAqQCAAF4AJAAKAC4ARg
BHAE0AVgBvAIoAqgDuADcBawGqAfMBKwJZAooCugLLArYCoAKIAm0CXgJDAhECzAF0AS8BCQHvANoAwwCSAFQAJwD9/9P/xv/E/8L/xP/F/9D/3//w/wUAEwAcADYAWAB6AKYAywDZAM8ArgCLAHcAZwA/AA0A3v+c/1r/IP/h/rf+lP5z/oP+pf6t/sP+u/56/nD+jv54/nf+jf5o/jT+
EP4B/vP9zP22/bn96P0k/jn+Wf5w/nP+jP6j/sv++f74/g3/K/8O/wD//v71/gD//f71/ur+1/7N/sL+uP6k/or+cP5i/nL+ev6D/pr+ov61/tn+D/9R/4D/of+y/7P/sv+1/7n/rf+O/23/Uf85/yn/Mf9P/3r/ov/Q/woAJwA6AHgAwQAJAUcBdQGMAXMBYwF1AZABqwGsAaABeQExAf
8A7wDwAN4AqQB5AEcAAgDb/9v/4f/N/7H/q/+5/9T///89AIUAtADQAPIAIAFLAWQBeAF+AWcBOwEPAfkA5wDAAIoARQAAALr/e/9n/2f/Xf9O/zn/MP8r/yj/M/87/zr/N/9A/2L/gv+c/6//u//I/8//4f///xQAJQAkAA8A6f+0/4j/Z/9I/yj/D//0/sf+mP55/nD+cP53/qf+6P4Z
/z//Uv9P/zX/Hf8q/1D/gf+j/6H/if9m/0b/Nv85/07/cP+R/6//yv/Q/7v/o/+g/7n/4v8HACcALgAbAAoABwANABcAIgAtAC0ALQAzADMAJAAJAPn/AAAPAB8ANgBOAFkAXwBqAH4AlwCkAKYApwCYAG4ANQD5/7z/h/9W/zD/Dv/j/sb+w/7S/vj+L/9o/6z/7v8fAGkAvQALAV8BsA
EDAjICRAJrAo4CrwKyApUCdgI3Au0BuwGgAY0BRgHsAKoAZAAzAB8AIQAoABIA9//0/xAARQCDANoALgFnAZUBxgEIAkECagKOApICegJRAiYCAgLRAZ0BaAExAQEB0wC8AL8AvwC4ALcAvACyAJ4AlgCTAIcAcABeAGkAdAB4AIkAnACmAKAAnwCwAL4AwQC3AKIAgwBHAAcA0v+c/2r/
NP8C/9b+pv6J/oT+kv61/t3+Df85/1n/cf9z/17/QP8a//v+9v4D/wj/8f6+/oP+WP5P/l3+fv6q/sf+0/7d/uj+9P7+/gr/J/9X/4f/sv/Q/+D/6P/x/wAAGAAsACsAHgASAAMA9f/j/83/vf+w/6//zP/1/w8AGAAdACgAOgBNAFwAXwBJABoA7P/N/6j/e/9M/wv/yP6M/lf+Qv5F/l
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
z/Fv8m/yn/IP8O//P+4v7l/vz+Gf8u/0L/Tf9U/1v/U/9J/yz///7Y/q3+g/5c/jT+B/7Z/br9p/2o/cf9AP5a/sP+JP+C/9j/LACAANMAKwFuAYwBgQFeATYBAwHRAKEAbgBDABIA3v+z/4f/XP82/xr/D/8L/wv/Cv8F/wD//P76/v7+Ev84/2T/k//B/+L/8P/u/+z/7v/v/+T/xf+b
/2j/Kv/z/tT+zf7N/tn+/v4u/2P/mP/R/xEARABgAIEAuADpAAsBNQFdAWcBVQFBAUcBWwFwAYgBmAGUAXgBXQFZAWEBaAFlAVoBRAElARUBFwEUAQAB4QDBAKcAmgCnAMkA6wD5APMA6gDiAOEA5gDpAOgA0wCwAJEAfAByAG0AawBsAG0AdwCHAKAAvgDTANwA3gDdANoA0wDGALAAig
BRABIA3P+y/5L/ef9i/0j/Jv8G//r++/4D/wr/Df8N/wP/+v77/gj/F/8d/yL/Jv8v/0X/Vf9m/3P/a/9T/yb/Bf/3/t3+vP6Y/nn+Vv4x/iL+I/4o/ij+Kv5P/or+0v4q/4D/z/8MAEcAjQDJAPkADwEQAQAB1QCoAHgAQAAJANH/qf+I/17/Nf8S//3+9v78/hX/KP8q/yL/G/8p/z7/
VP9v/4X/m/+2/9L/6//2/+//3P/U/9P/y/+0/4H/Pv/z/rX+lv6L/or+h/6P/rX+6f4z/4r/4v8wAGQAowD4AEIBgAGpAcUBzAGwAZMBfwF1AWQBQQEqAQoB3gC8ALIAyQDZANYAzwC+ALMAsADAAOMA8ADaALEAlACaAK8A1QABARYBEAH3AO0A+AD8APUA3QC+AJsAbwBUAEcANAARAP
H/7/8CACMAUgCCAKwAvgDCANUA7QD/AAYBAQHsALsAdwA9ABQA9v/X/7r/pP+G/2L/S/9C/z3/LP8Z/xb/Gf8f/yD/IP8i/xn/F/8p/1L/gf+Z/6L/ov+W/4H/YP9O/0L/KP8M//D+1P6s/n7+Xv5K/kP+R/5a/of+vv7//k7/l//b/xwAZQC3AP4AMwFPAUoBKQH1AMcAoQB5AFAAKAAK
APL/1//C/7P/q/+p/6P/of+g/5r/jf9//4T/kv+g/7L/y//t/woAGgAnADAAMAAnABsADQDz/8D/f/9K/yX/Cv/6/v3+Dv8l/0v/if/b/ykAaQClAOEAJAFsAa8B8gEfAiwCIgIKAvgB6wHfAc4BsAGMAVYBJAERARABHAEfARUBDAH6AO0A9gALASQBLAElAR0BHQEmATIBRQFcAWsBdg
F4AXoBeQFlAUEBDgHdALEAfwBWADcAGAD5/9j/0f/g/wAANQBrAKAAzQDwABEBMAFLAVcBUAE+AR8B+wDQAJcAWQAUAND/kf9f/0P/MP8Z/wL/8P7h/sz+vf7C/tT+5f7y/gb/I/88/1X/d/+e/7L/qv+X/4r/hP92/1//Rf8g/+n+rP6G/n3+bP5B/gv+5/3b/d/9Af5G/pb+0v4B/0j/
nv/k/xsAVQCQALMAtwCxAJ8AcwA3AAkA9//n/8z/rf+O/2v/Rf8p/xv/Dv/9/vL+7/7t/uv+5/7l/uT+5v74/hf/MP88/0L/Qv89/yz/FP8D//r+9/7w/uz+8f7t/uX+5v4A/zL/Xv+M/8D/7/8uAG4AuwAYAWABkwGnAasBqwGdAZABeQFRARoBzACNAGcAWABaAE8AQAApAAwACwAnAF
YAewCJAJMAmwCuANIA/AAdAR8BEgEPARwBOgFXAWkBWwEmAeYAqgCBAGcATwA4ABYA6v/D/6T/mv+s/8j/6/8QAD0AbwCYAMUA8QASASUBJwEvAToBLwEMAdAAggAnANP/nf+C/3P/YP9G/yv/Df/6/vf+Af8T/yn/Qv9Y/2j/cf9+/5T/pv+8/93/9v/5/+v/2//E/6X/ff9O/yT/8/6x
/nH+OP4A/s39rf2t/cz9+v0x/nT+vP4F/0//mv/x/0kAkgDLAPMABQEHAfsA6gDXAL4AmwBqADQAAQDS/6X/dv9D/xL/7f7Z/tL+0f7T/sz+u/6x/rj+zP7f/u7+9f73/vj+9f7z/vn+B/8Z/zH/Vv9+/5z/t//Z/wcAOQBiAHoAdwCAAJ0AwQADAUUBcgF9AW0BbwF3AYEBeQFTASMB2A
CPAGgAVQBSADoAHAAOAAAACwAyAGkApQDNAOgA9wAIASkBTgF6AZsBqAGkAYYBaAFZAVEBSwE2ARsB/wDcAMAAqACRAGsANAAJAO//6f/z//n////6//v/DQAzAHAAsQDpABIBLAFNAWsBfgGMAYYBbQE+AQMBzgCTAFUAGADd/6v/gP9k/1v/Wv9V/0r/Rv9R/2P/fv+s/97/AwAkAEoA
dQCaAKoAoQB/AE0AGwDu/8z/rv93/yL/wf5u/jD+DP4E/hT+Kv44/kH+Wf6B/q7+3v4i/3j/zv8XAFUAhwCkALMAyQDgAPEA9ADlAMUAlQBdAB8A4P+m/3j/W/9M/z//LP8T//n+5f7j/uv+6/7h/sj+ov53/lf+Sv5L/ln+eP6p/uj+KP9m/6n/7f8wAG4AqgDwACgBUAF7AZoBpwGUAX
EBXgFRAVEBUQFEASEB1wCMAFkAOwAsABUA/P/c/7b/pv+s/7//z//S/+P/DABMAJUA2QATATQBQQFTAXQBoQG8AbkBoAFzATwB/gDMAKgAgQBXACwACwDy/9b/vv+q/5X/e/9l/2P/bv97/43/mv+j/6z/wf/0/zoAhQDGAPQAEgEeASIBNQFJAVEBQwEZAd4AlQBLAAMAvP96/zb/9/7N
/rP+rf6w/rL+vf7I/uT+H/9l/6v/2//0//3/8f/k/+T/7P/l/7r/h/9U/x7/7v7K/sH+uv6q/qX+rv68/r3+tv61/q7+q/6w/sP+4f75/hf/Nf9R/3L/jf+s/8v/6P8JABwAJgAmABcABADt/93/0v+7/6X/kv+A/2b/SP8z/xj/8/7G/pf+cP5E/hX+9P3n/er98P0L/jn+cf6z/vv+Uf
+e//H/XADBACkBgwHCAeMB1wHNAcoBxgG+AZYBZgEXAbQAbgA+ACgACwDY/6n/cP8//yb/J/8//0r/Uv9l/4r/xv8HAFYAoADUAAkBQAGEAcUB5QHtAdgBsQGDAVgBRQEsAQIBzQCRAFkAHADq/9D/w//D/8j/0f/Z/9j/2P/c/+j/+v8KACEAOwBWAHMAjQCjALIAvgDXAPkAHQE4ATwB
LQEOAe0A0AC2AJsAdQBFABQA6P/C/53/fP9m/2P/ff+d/7b/wv+x/5H/f/+C/5b/p/+q/5X/av9B/yj/I/8j/yL/Lf8//1f/bv+E/53/pP+k/6z/v//Q/83/uv+i/4X/aP9N/0H/R/9S/1//bv9//5L/mv+k/8T/+f8vAFAAYwBsAG0AZwBjAG4AdQBnAFAAOgAlAAMAzP+F/zv/+v7F/q
H+j/6F/nj+a/5t/pD+yv4Q/1j/oP///2QAxwA4AaQB9wEeAjECTgJmAnsCdQJWAiMCyQFqAR0B6QC8AHcALgDq/6L/a/9N/03/VP9V/1f/Xv+A/7T/+/9XALAABgFWAaEB7AEqAlwCdwJ1AmECPwIdAvkBzAGVAUgB7gCSAD8ADQDz/+b/3v/O/8f/yv/a//z/HgA8AEgAUQBnAH4AmgCt
ALQAswCoAKYArwC3ALYAowCOAIAAdABuAGwAawBhAEsANQAdAAAA5f/K/7z/uv+0/6X/kP+A/27/T/8+/zr/Kf8E/9f+wP6v/ov+af5X/lP+SP5D/mr+pv7W/vf+Jf9k/43/pP+//9r/6//p/+T/4P/O/7D/gP9U/zn/H/8M/wH//v4C//v+9f7+/hT/Nf9Z/4X/tv/f/wAAIgBQAHoAkA
CXAI4AdgBTACEA7f+p/1f/Bv/B/pb+gP5z/m7+aP5s/n/+n/7R/gf/TP+g//z/ZADEABABQAFdAYABrwHmAQ4CEwL4AbwBewE+AQQBygB7AB8Av/9n/yT/6/67/pb+gP6A/pr+1/4p/37/2f81AJgA8wBBAY4B1wEMAiECIgIUAu0BvAGVAXoBWAEZAccAcgAlAOv/xf+x/6T/k/+D/4r/
rP/T//D/AwAQACAAOgBjAJMAsgC6AK8AngCVAJUAlwCVAIQAYgAyAAEA3f/K/8T/yP/P/8r/tv+d/47/kP+e/6z/tP+6/7L/qf+n/6H/jP9e/yX/9P7T/sL+qv6F/lD+E/7m/dP94/0P/j7+bv6c/tX+Gf9V/4z/uP/g/wQAHAAsADAAJAANAPX/5//a/8D/oP+A/2j/VP9B/y7/Fv8G/w
f/HP9J/3P/kP+g/7L/2P8LAEcAdgCHAHoAWwA8ABgA5v+m/13/Gf/j/sX+wf6+/rj+s/6//uj+H/9Z/4z/xP8GAEkAlwDuADcBaAGEAagB2AECAiACGQLwAbABWQEJAcUAgQA2ANz/g/8r/9/+uf6u/rX+yf7t/iT/ZP+4/yIAkgD8AE0BiwHEAfcBGQInAisCGgLyAcgBrAGfAYMBRQH5
AKUAVgAiAAYAAQAJAAoA/v/3/wgAIgBEAHMAnwDCAOEAAgEiATwBUQFeAVwBVgFOAT8BKAENAeYAsgCAAE0AEwDm/8n/r/+V/3r/av9e/1P/Xf9v/3//k/+Z/5v/ov+k/5v/hP9r/0//Of8s/yH/Ev/o/rP+g/5L/jD+Nf48/k7+aP6P/sj+Bv8//23/o//T/wAAOABeAG8AYgBAAC4AFQ
AFAAQA8//d/8r/tf+f/4r/df9W/1L/Zf9v/4f/nf+t/8T/4P8cAF0AfgCWAJcAfgBlAEUACQDK/4//O//2/t3+uv6c/pL+kf6m/tT+Gv9s/7T/8f8nAGAAmQDaACUBZQGlAdQB5gH3AfQB2AGxAX4BSAH5AKAAWAAOAMD/eP8y/+/+zP7L/tT+Bv9b/5j/zv8mAI8A+QBfAbQB8gEfAjQC
QQJWAmACRgIGAsUBlQFTAQsB2wCjAFcAHAD3/+L/4v/o/+3/+P8IAB4APQBnAKAA1AD9AC0BSgFPAWYBfwGGAY8BlgF8AU8BKgH6AMQAmgB'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:43'
}
SRAudio >> ensureOpenAL [

	"noop"
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 1/8/2026 18:06'
}
SRAudio >> initialize [

	super initialize.
	
	self setup
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/8/2026 18:09'
}
SRAudio >> play: audio [

	| source buffer |
	source := ExternalType uint32_t allocate.
	OpenAL alGenSourcesN: 1 sources: source.
	self checkErrorAl.
	
	buffer := ExternalType uint32_t allocate.
	OpenAL alGenBuffersN: 1 buffers: buffer.
	self checkErrorAl.
	
	OpenAL alBufferDataBuffer: buffer first
			format: AlDefines alFormatMono16
			data: audio
			size: audio size * 2
			samplerate: 44100.
	self checkErrorAl.
	OpenAL alSourceiSource: source first param: AlDefines alBuffer value: buffer first.
	self checkErrorAl.
		"alSourceQueueBuffersSource: source first nb: 1 buffers: buffer;"
	OpenAL alSourcePlaySource: source first.
	self checkErrorAl.
	
	4 seconds wait.
	
	OpenAL alDeleteSourcesN: 1 sources: source.
	self checkErrorAl.
	OpenAL alDeleteBuffersN: 1 buffers: buffer.
	self checkErrorAl.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/18/2025 16:10'
}
SRAudio >> record [

	| count recordingDevice buffer |
	recordingDevice := OpenAL alcCaptureOpenDeviceDevicename: nil frequency: 24000 format: AlDefines alFormatMono16 buffersize: 32768.
	self checkErrorAlc: 'alcCaptureOpenDeviceDevicename:'.
	OpenAL alcCaptureStartDevice: recordingDevice.
	self checkErrorAlc: 'alcCaptureStartDevice:'.
	
	10 second wait.
	
	count := ExternalType int32_t allocate.
	OpenAL alcGetIntegervDevice: recordingDevice param: AlDefines alcCaptureSamples size: 1 values: count.
	self checkErrorAlc: 'alcGetIntegervDevice:'.
	Transcript showln: 'got samples ', count asString.
	
	buffer := ExternalType int16_t allocate: count first.
	OpenAL alcCaptureSamplesDevice: recordingDevice buffer: buffer samples: count first.
	self checkErrorAlc: 'alcCaptureSamplesDevice:'.
	OpenAL alcCaptureStopDevice: recordingDevice.
	self checkErrorAlc: 'alcCaptureStopDevice:'.
	OpenAL alcCaptureCloseDevice: recordingDevice.
	self checkErrorAlc: 'alcCaptureCloseDevice:'.
	^ buffer
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/8/2026 18:08'
}
SRAudio >> setup [	
	
	| name |
	device := OpenAL alcOpenDeviceDevicename: nil.
	device ifNil: [
		Transcript showln: self class name, ': Failed to open audio device!'.
		^ self].
	self checkErrorAlc.
	
	context := OpenAL alcCreateContextDevice: device attrlist: nil.
	context ifNil: [
		OpenAL alcCloseDevice: device.
		Transcript showln: self class name, ':Failed to create audio context'.
		^ self].
	self checkErrorAlc.
	
	(OpenAL alcMakeContextCurrentContext: context) = 0 ifTrue: [
		OpenAL alcDestroyContext: context.
		OpenAL alcCloseDevice: device.
		Transcript showln: self class name, ':Could not set an audio context!'].
	self checkErrorAlc.
	
	name := OpenAL alcGetStringDevice: device param: AlDefines alcAllDevicesSpecifier.
	Transcript showln: self class name, ': Opened "', name, '"'.
]
