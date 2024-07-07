const VolumeSlider = (source) =>
  Widget.Slider({
    draw_value: false,
    class_name: "volume-slider",
    hexpand: true,
    on_change: ({ value }) => (source.volume = value),
  }).hook(source, (self) => {
    if (!source) return;
    self.value = source.volume;
  });

export default VolumeSlider;
