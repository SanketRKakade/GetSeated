import 'package:app_frontend/features/home_page/ui/layout.dart';
import 'package:app_frontend/features/scanner/countdown_timer_widget.dart';
import 'package:app_frontend/features/scanner/scanner.dart';
import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SeatArrangement extends StatefulWidget {
  const SeatArrangement({Key? key}) : super(key: key);

  @override
  State<SeatArrangement> createState() => _SeatArrangementState();
}

class _SeatArrangementState extends State<SeatArrangement> {
  Set<SeatNumber> selectedSeats = Set();
  bool hasbooked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          hasbooked
              ? Text("You have already Booked a seat.")
              : Text("Reading Hall seats"),
          const SizedBox(
            height: 16,
          ),
          hasbooked
              ? CountdownTimerWidget(
                  duration: Duration(minutes: 30), // Set your desired duration
                  onFinish: () {
                    // Code to execute when the timer finishes (optional)
                  },
                )
              : Container(),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 2 - 170, 0, 0, 0),
              width: double.maxFinite,
              height: 500,
              child: SeatLayoutWidget(
                onSeatStateChanged: (rowI, colI, seatState) {
                  if (hasbooked) {
                    return;
                  }
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  if (seatState == SeatState.selected) {
                    if (selectedSeats.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: seatState == SeatState.selected
                              ? Text("Selected Seat[$rowI][$colI]")
                              : Text("De-selected Seat[$rowI][$colI]"),
                        ),
                      );
                      selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("You can only book one seat at a time")));
                    }
                  } else {
                    selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
                  }
                },
                stateModel: SeatLayoutStateModel(
                  pathDisabledSeat: 'assets/components/disabled.svg',
                  pathSelectedSeat: 'assets/components/selected.svg',
                  pathSoldSeat: 'assets/components/occupied.svg',
                  pathUnSelectedSeat: 'assets/components/unselected.svg',
                  rows: 23,
                  cols: 33,
                  seatSvgSize: 10,
                  currentSeatsState: layout,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/components/disabled.svg',
                      width: 15,
                      height: 15,
                    ),
                    const Text('Disabled')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/components/occupied.svg',
                      width: 15,
                      height: 15,
                    ),
                    const Text('Booked')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/components/unselected.svg',
                      width: 15,
                      height: 15,
                    ),
                    const Text('Available')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/components/selected.svg',
                      width: 15,
                      height: 15,
                    ),
                    const Text('Selected')
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {
              if (hasbooked) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("You have already booked a seat"),
                ));
                return;
              }
              if (selectedSeats.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please select a seat"),
                ));
                return;
              }
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => QrScannerWithOverlay()))
                  .then((value) {
                if (value == "123456789") {
                  hasbooked = true;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Seat booked successfully"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Invalid Qr Code"),
                  ));
                }
                setState(() {
                  selectedSeats.clear();
                });
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => const Color(0xFFfc4c4e)),
            ),
            child: const Text('Book My Seat'),
          ),
          const SizedBox(height: 12),
          Text(selectedSeats.join(" , "))
        ],
      ),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI &&
        colI == (other as SeatNumber).colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
