import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/flashlight_model.dart';
import '../service/flashlight_service.dart';

class FlashlightViewModel extends ChangeNotifier {
  final FlashlightService _service = FlashlightService();
  FlashlightModel _model = FlashlightModel(isOn: false);
  final AudioPlayer _audioPlayer = AudioPlayer();

  FlashlightModel get model => _model;

  Future<void> _playClickSound() async {
    _audioPlayer.stop();
    await _audioPlayer.play(AssetSource("sounds/flashlight.mp3"));
  }

  void toggleFlashlight() async {
    HapticFeedback.mediumImpact();
    _playClickSound();
    if (_model.isOn) {
      await _service.turnOff();
    } else {
      await _service.turnOn();
    }

    _model = FlashlightModel(isOn: !_model.isOn);
    notifyListeners();
  }
}
