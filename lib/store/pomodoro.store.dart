import 'dart:async';

import 'package:mobx/mobx.dart';
part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalor { trabalho, descanso }

abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
  int minutos = 2;
  @observable
  int segundos = 0;

  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  TipoIntervalor tipoIntervalor = TipoIntervalor.trabalho;

  Timer? cronometro;

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutos == 0 && segundos == 0) {
        _trocarTipoIntervalor();
      } else if (segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estarTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  @action
  void incrementarTempoTrabalho() {
    tempoTrabalho++;
    if (estarTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoTrabalho() {
    tempoTrabalho--;
    if (estarTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;
    if (estadescansando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    tempoDescanso--;
    if (estadescansando()) {
      reiniciar();
    }
  }

  bool estarTrabalhando() {
    return tipoIntervalor == TipoIntervalor.trabalho;
  }

  bool estadescansando() {
    return tipoIntervalor == TipoIntervalor.descanso;
  }

  void _trocarTipoIntervalor() {
    if (estarTrabalhando()) {
      tipoIntervalor = TipoIntervalor.descanso;
      minutos = tempoDescanso;
    } else {
      tipoIntervalor = TipoIntervalor.trabalho;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }
}
