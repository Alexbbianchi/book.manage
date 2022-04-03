import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/common/utility/common_service.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/book_form_back.dart';
import 'package:projeto_integrador_app/app/common/enums/book_status_type.dart';

class BookNotesView extends StatefulWidget {
  final BookFormBack? back;

  const BookNotesView({Key? key, this.back}) : super(key: key);

  @override
  _BookNotesViewState createState() => _BookNotesViewState();
}

class _BookNotesViewState extends State<BookNotesView> {
  @override
  Widget build(BuildContext context) {
    return Scroll(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _evaluationRating,
            _pagesReadSlider,
            _statusInfo,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _startDateInfo,
                const Padding(padding: EdgeInsets.only(top: 10)),
                _endDateInfo,
                const Padding(padding: EdgeInsets.only(top: 10)),
              ],
            ),
            _notesField(),
          ],
        ),
      ),
    );
  }

  Widget get _evaluationRating {
    return RatingBar.builder(
      initialRating: widget.back!.book!.evaluation ?? 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ignoreGestures: true,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (value) {},
    );
  }

  Widget get _pagesReadSlider {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Páginas lidas:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Slider(
                value: widget.back!.book!.pagesRead!.toDouble(),
                min: 0,
                max: widget.back!.book!.pages!.toDouble(),
                onChanged: (double newSliderValue) {},
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${widget.back!.book!.pagesRead!.round()}/${widget.back!.book!.pages!.round()}',
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget get _statusInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Status",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(widget.back!.book!.status.description),
        ],
      ),
    );
  }

  Widget get _startDateInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Início",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(CommonService.formattedDate(widget.back!.book!.startDate)),
        ],
      ),
    );
  }

  Widget get _endDateInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Fim",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(CommonService.formattedDate(widget.back!.book!.endDate)),
        ],
      ),
    );
  }

  Widget _notesField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Anotações",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.from(widget.back!.book!.notes!.reversed)
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
