import 'dart:io';
import 'dart:math';

import 'package:chat/services/reservation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_datetime_picker/src/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          CupertinoDialogAction(
            child: Text('ok'),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        MaterialButton(
          child: Text('OK'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

addReservation(BuildContext context, String idReservacion) {
  final textController = new TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Reservar"),
      content: TextButton(
          onPressed: () {
            DatePicker.showPicker(context, showTitleActions: true,
                onChanged: (date) {
              print('change $date in time zone ' +
                  date.timeZoneOffset.inHours.toString());
            }, onConfirm: (date) {
              print('confirm $date');
              String formattedDate = format.format(date);
              textController..text = formattedDate;
            },
                pickerModel: BookingTimePicker(
                    currentTime: DateTime.now(), locale: LocaleType.es));
          },
          child: Container(
            height: 100,
            child: Column(
              children: [
                Text(
                  'Seleccione aqui la fecha y hora de su reservación',
                  style: TextStyle(color: Colors.blue),
                ),
                TextField(
                  controller: textController,
                  autocorrect: false,
                  enabled: false,
                )
              ],
            ),
          )),
      actions: [
        MaterialButton(
          child: Text('Agregar'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () async {
            final reservation =
                Provider.of<ReservationService>(context, listen: false);
            String date = textController.text.split(" ")[0];
            String hour = textController.text.split(" ")[1];
            var res =
                await reservation.saveReservation(idReservacion, date, hour);
            if (!res['res']) {
              Navigator.pop(context);
              mostrarAlerta(context, 'Error', res['msg']);
            } else {
              reservation.arrayReservation = [];
              Navigator.pop(context);
              mostrarAlerta(
                  context, 'Reservaciones', 'Cita agendada exitosamente');
            }
          },
          //onPressed: () => addBandToList(textController.text),
        )
      ],
    ),
  );
}

class BookingTimePicker extends DateTimePickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  BookingTimePicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(0);
    this.setMiddleIndex(this.currentTime.hour);
    this.setRightIndex(0);
  }

  bool isAtSameDay(DateTime day1, DateTime day2) {
    return day1 != null &&
        day2 != null &&
        day1.difference(day2).inDays == 0 &&
        day1.day == day2.day;
  }

  @override
  void setLeftIndex(int index) {
    super.setLeftIndex(index);

    DateTime time = currentTime.add(Duration(days: index));
    if (isAtSameDay(minTime, time)) {
      var index = min(24 - minTime.hour - 1, currentMiddleIndex());
      this.setMiddleIndex(index);
    } else if (isAtSameDay(maxTime, time)) {
      var index = min(maxTime.hour, currentMiddleIndex());
      this.setMiddleIndex(index);
    }
  }

  @override
  void setMiddleIndex(int index) {
    super.setMiddleIndex(index);
    DateTime time = currentTime.add(Duration(days: currentLeftIndex()));
    if (isAtSameDay(minTime, time) && index == 0) {
      var maxIndex = 60 - minTime.minute - 1;
      if (currentRightIndex() > maxIndex) {
        setRightIndex(maxIndex);
      }
    } else if (isAtSameDay(maxTime, time) &&
        currentMiddleIndex() == maxTime.hour) {
      var maxIndex = maxTime.minute;
      if (currentRightIndex() > maxIndex) {
        setRightIndex(maxIndex);
      }
    }
  }

  @override
  String leftStringAtIndex(int index) {
    DateTime time = currentTime.add(Duration(days: index));
    if (minTime != null &&
        time.isBefore(minTime) &&
        !isAtSameDay(minTime, time)) {
      return null;
    } else if (maxTime != null &&
        time.isAfter(maxTime) &&
        !isAtSameDay(maxTime, time)) {
      return null;
    }
    return formatDate(time, [ymdw], locale);
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index == 0 || index == 1 || index == 2 || index == 3) {
      if (index == 0) {
        return '0';
      } else if (index == 1) {
        return '15';
      } else if (index == 2) {
        return '30';
      } else if (index == 3) {
        return '45';
      }
    } else {
      return null;
    }
  }

  @override
  DateTime finalTime() {
    DateTime time = currentTime.add(Duration(days: currentLeftIndex()));
    var hour = currentMiddleIndex();
    var minute = convertIndexToQuarter(currentRightIndex());
    if (isAtSameDay(minTime, time)) {
      hour += minTime.hour;
      if (minTime.hour == hour) {
        minute += minTime.minute;
      }
    }

    return currentTime.isUtc
        ? DateTime.utc(time.year, time.month, time.day, hour, minute)
        : DateTime(time.year, time.month, time.day, hour, minute);
  }

  int convertIndexToQuarter(int index) {
    if (index == 0) {
      return 0;
    } else if (index == 1) {
      return 15;
    } else if (index == 2) {
      return 30;
    } else if (index == 3) {
      return 45;
    } else {
      return 0;
    }
  }

  @override
  List<int> layoutProportions() {
    return [4, 1, 1];
  }

  @override
  String rightDivider() {
    return ':';
  }
}

/*   void addBandToList(String name) {
    if (name.length > 1) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.socket.emit('add-band', {'name': name});
    }
    Navigator.pop(context);
  } */
