import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoromobx/components/cronometro_botao.dart';
import 'package:pomodoromobx/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Observer(builder: (_) {
      return Container(
        color: store.estarTrabalhando() ? Colors.red : Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              store.estarTrabalhando()
                  ? 'Hora de Trabalhar'
                  : 'Hora de descansar',
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 120,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!store.iniciado)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CronometroBotao(
                      texto: 'Iniciar',
                      icone: Icons.play_arrow,
                      clik: store.iniciar,
                    ),
                  ),
                if (store.iniciado)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CronometroBotao(
                      texto: 'Parar',
                      icone: Icons.stop,
                      clik: store.parar,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CronometroBotao(
                    texto: 'Reiniciar',
                    icone: Icons.refresh,
                    clik: store.reiniciar,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
