import Audio from "resource:///com/github/Aylur/ags/service/audio.js"
import Gtk from "gi://Gtk?version=3.0"
// import Dropdown from "./../../Components/Dropdown.js"

const ComboBoxText = Widget.subclass(Gtk.ComboBoxText)

const update = (box) => {
  // console.log(Audio.speakers)
  // console.log(Gtk.ComboBox)

  const activeIndex = Audio.speakers.findIndex(
    (speaker) => speaker.id === Audio.speaker.id
  )

  // const comboBox = new Dropdown({
  //   className: "device-dropdown",
  //   // options: ["a", "b", "c", "d", "e"],
  //   options: Audio.speakers.map((speaker) => speaker.description),
  //   active: activeIndex,
  //   onChange: (self) => {
  //     const newSpeaker = Audio.speakers[self.active]
  //     Audio.speaker = newSpeaker
  //   },
  // })

  // const activeMicIndex = Audio.microphones.findIndex(
  //   (mic) => mic.id === Audio.microphone.id
  // )

  // const microphoneBox = new Dropdown({
  //   className: "device-dropdown",
  //   // options: ["a", "b", "c", "d", "e"],
  //   options: Audio.microphones.map((mic) => mic.description),
  //   active: activeMicIndex,
  //   onChange: (self) => {
  //     const newMic = Audio.mic[self.active]
  //     Audio.microphone = newMic
  //   },
  // })

  const OutputDevices = ComboBoxText({
    class_name: "normal-button",
  }).on("changed", (self) => {
    const newSpeaker = Audio.speakers[self.active]
    Audio.speaker = newSpeaker
  })

  Audio.speakers.forEach((speaker) => {
    OutputDevices.append(`${speaker.id}`, speaker.description)
  })

  OutputDevices.active = activeIndex
  // OutputDevices.on("changed", (self) => {
  //   //print(OutputDevices.get_active_id())
  //   var streamID = parseInt(OutputDevices.get_active_id())
  //   if (streamID == null) {
  //     streamID = 1
  //   }
  //   Audio.speaker = Audio.getStream(streamID)
  // })
  // OutputDevices.hook(
  //   Audio,
  //   (self) => {
  //     self.remove_all()
  //     // Set combobox with output devices
  //     for (let i = 0; i < Audio.speakers.length; i++) {
  //       let device = Audio.speakers[i]
  //       self.append(`${device.id}`, device.description)
  //     }
  //     OutputDevices.set_active_id(Audio.speaker.id.toString())
  //   },
  //   "speaker-changed"
  // )
  // const microphoneBox = new Dropdown({
  //   className: "device-dropdown",
  //   // options: ["a", "b", "c", "d", "e"],
  //   options: Audio.speakers.map((speaker) => speaker.description),
  //   active: activeIndex,
  //   onChange: (self) => {
  //     const newSpeaker = Audio.speakers[self.active]
  //     Audio.speaker = newSpeaker
  //   },
  // })

  box.children = [OutputDevices]
}

const AudioDevices = () =>
  Widget.Box({
    vertical: true,
    className: "audio-device-control-wrapper",
    children: [
      Widget.Box({
        //     className: "audio-device-picker",
        //     children: Widget.Overlay({
        //       child: Widget.Box({
        //         expand: true,
        //         className: "test-two",
        //       }),
        //       overlays: [
        //         Widget.Label({
        //           label: "test",
        //         }),
        //         Widget.Label({
        //           label: "test",
        //         }),
        //         Widget.Label({
        //           label: "test",
        //         }),
        //       ],
        //     }),
      }),
    ],
  }).hook(Audio, update, "speaker-changed")

export default AudioDevices
