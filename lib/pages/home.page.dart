import 'package:aog/widgets/logo.widget.dart';
import 'package:aog/widgets/submit-form.dart';
import 'package:aog/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = new MoneyMaskedTextController();

  var _alcCtrl = new MoneyMaskedTextController();

  var _busy = false;

  var _completed = false;

  var _resultText = "Compensa utilizar álcool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 1200,
        ),
        color: this._color,
        child: ListView(
          children: <Widget>[
            Logo(),
            this._completed
                ? Success(
                    result: this._resultText,
                    reset: this.reset,
                  )
                : SubmitForm(
                    gasCtrl: this._gasCtrl,
                    alcCtrl: this._alcCtrl,
                    busy: this._busy,
                    submitFunc: calculate,
                  ),
          ],
        ),
      ),
    );
  }

  Future calculate() {
    double alc =
        double.parse(this._alcCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;
    double gas =
        double.parse(this._gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;

    double res = alc / gas;

    setState(() {
      this._color = Colors.purpleAccent;
      this._completed = false;
      this._busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (res >= 0.7) {
          this._resultText = "Compensa utilizar Gasolina!";
        } else {
          this._resultText = "Compensa utilizar Ácoool!";
        }
        this._busy = false;
        this._completed = true;
      });
    });
  }

  reset() {
    setState(() {
      this._alcCtrl = new MoneyMaskedTextController();
      this._gasCtrl = new MoneyMaskedTextController();
      this._completed = false;
      this._busy = false;
      this._color = Colors.deepPurple;
    });
  }
}
