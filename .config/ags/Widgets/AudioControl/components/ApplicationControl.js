import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import AudioButton from "./control/AudioButton.js";
import VolumeSlider from "./control/VolumeSlider.js";

const update = (box) => {
  box.children = Audio.apps.map((stream) => {
    return Widget.Box({
      vertical: true,
      class_name: "slider-label-wrapper",
      children: [
        Widget.Box({
          children: [
            Widget.Label({
              className: "volume-label",
              truncate: "end",
              maxWidthChars: 40,
              justification: "left",
              label: `${stream.name} (${stream.description})`,
            }),
          ],
        }),
        Widget.Box({
          className: "volume-button-stack",
          children: [VolumeSlider(stream), AudioButton(stream)],
        }),
      ],
    });
  });
};

const ApplicationSliderWrapper = () =>
  Widget.Box({
    expand: true,
    vertical: true,
    spacing: 10,
  })
    .hook(Audio, update, "stream-removed")
    .hook(Audio, update, "stream-added");

export default ApplicationSliderWrapper;
