import 'package:cloud_firestore/cloud_firestore.dart';

class LastVisitInterpretrer{
  static String getElapsedPeriod(Timestamp? lastVisit){
    if(lastVisit != null){
      // Obtém a data e hora atual
      DateTime dataAtual = DateTime.now();

      // Calcula a diferença de tempo entre a data de visita e a data atual
      Duration duracao = dataAtual.difference(lastVisit.toDate());

      // Calcula a diferença em anos, meses, semanas e dias
      int anos = duracao.inDays ~/ 365;
      int meses = (duracao.inDays % 365) ~/ 30;
      int semanas = ((duracao.inDays % 365) % 30) ~/ 7;
      int dias = ((duracao.inDays % 365) % 30) % 7;

      String diff = '';
      // Formata o resultado em uma string
      if (dias > 0) {
        diff = 'Última visita a $dias dia${dias > 1 ? 's' : ''}';
      }
      if (semanas > 0) {
        diff = 'Última visita a $semanas semana${semanas > 1 ? 's' : ''} ';
      }
      if (meses > 0) {
        diff = 'Última visita a $meses mes${meses > 1 ? 'es' : ''} ';
      }
      if (anos > 0) {
        diff = 'Última visita a $anos ano${anos > 1 ? 's' : ''} ';
      }
      // Retorna o resultado formatado
      if (diff.isEmpty) {
        return 'Última visita hoje';
      } else {
        return diff;
      }
    }else{
      return "Nunca visitou!";
    }

  }
}