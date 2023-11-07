import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class Login extends StatelessWidget {
   Login({super.key});

   final Color primaryColor = Colors.amberAccent;
   final TextEditingController emailCont = TextEditingController();
   final TextEditingController passwordCont = TextEditingController();
   final FocusNode emailFocus = FocusNode();
   final FocusNode passwordFocus = FocusNode();


   Widget _buildTopWidget() {
    return Column(
      children: [
        Text("Hello!", style: boldTextStyle(size: 24)).center(),
        16.height,
        Text("Wha gwann?", style: primaryTextStyle(size: 16), textAlign: TextAlign.center).center().paddingSymmetric(horizontal: 32),
        32.height,
      ],
    );
  }

  Widget _buildFormWidget() {
    return AutofillGroup(
      child: Column(
        children: [
          AppTextField(
            textFieldType: TextFieldType.EMAIL,
            controller: emailCont,
            focus: emailFocus,
            nextFocus: passwordFocus,
            errorThisFieldRequired: "Please fill in this field",
            autoFillHints: const [AutofillHints.email],
          ),
          16.height,
          AppTextField(
            textFieldType: TextFieldType.PASSWORD,
            controller: passwordCont,
            focus: passwordFocus,
            // suffixPasswordVisibleWidget: ic_show.iconImage(size: 10).paddingAll(14),
            // suffixPasswordInvisibleWidget: ic_hide.iconImage(size: 10).paddingAll(14),
            autoFillHints: const [AutofillHints.password],
            onFieldSubmitted: (s) {
              
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRememberWidget() {
    var primaryColor = Colors.amberAccent ;
    return Column(
      children: [
        8.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedCheckBox(
              borderColor: primaryColor,
              checkedColor: primaryColor,
              text: "remember me?",
              textStyle: secondaryTextStyle(),
              size: 20,
              onTap: (value) async {
              },
            ),
            TextButton(
              onPressed: () {

              },
              child: Text(
                "forgot password?",
                style: boldTextStyle(color: primaryColor, fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
            ).flexible(),
          ],
        ),
        24.height,
        AppButton(
          text: "Sign in",
          color: primaryColor,
          textStyle: boldTextStyle(color: white),
          width: 12.0,
          onTap: () {
          },
        ),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Do not have an account?", style: secondaryTextStyle()),
            TextButton(
              onPressed: () {
              },
              child: Text(
                "signUp",
                style: boldTextStyle(
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            if (isAndroid) {
              print("this is an android phone");
            } else if (isIOS) {
              print("this is an ios phone");
            }
          },
          child: Text("Register as a partner", style: boldTextStyle(color: primaryColor)),
        )
      ],
    );
  }

  Widget _buildSocialWidget() {
    return Column(
      children: [
        20.height,
        Row(
          children: [
            const Divider(color: Colors.orangeAccent, thickness: 2).expand(),
            16.width,
            Text("or continue with", style: secondaryTextStyle()),
            16.width,
            const Divider(color:  Colors.orangeAccent, thickness: 2).expand(),
          ],
        ),
        24.height,
        AppButton(
          text: '',
          color: Colors.red,
          padding: const EdgeInsets.all(8),
          textStyle: boldTextStyle(),
          width: 20,
          onTap: (){},
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: primaryColor.withOpacity(0.1),
                  boxShape: BoxShape.circle,
                ),
                child: GoogleLogoWidget(size: 18),
              ),
              Text("SignInWithGoogle", style: boldTextStyle(size: 14), textAlign: TextAlign.center).expand(),
            ],
          ),
        ),
        16.height,
        AppButton(
          text: '',
          color: primaryColor.withOpacity(0.5),
          padding: const EdgeInsets.all(8),
          textStyle: boldTextStyle(),
          width: 20,
          onTap: (){},
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: primaryColor.withOpacity(0.1),
                  boxShape: BoxShape.circle,
                ),
                child: const Placeholder(),
              ),
              Text("sign in with otp", style: boldTextStyle(size: 14), textAlign: TextAlign.center).expand(),
            ],
          ),
        ),
        16.height,
        if (isIOS)
          AppButton(
            text: '',
            color: primaryColor.withGreen(50),
            padding: const EdgeInsets.all(8),
            textStyle: boldTextStyle(),
            width: 200,
            onTap: (){},
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: primaryColor.withOpacity(0.1),
                    boxShape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.apple),
                ),
                Text("SignInWithApple", style: boldTextStyle(size: 14), textAlign: TextAlign.center).expand(),
              ],
            ),
          ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light, statusBarColor: Colors.transparent)),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (context.height() * 0.05).toInt().height,
                _buildTopWidget(),
                _buildFormWidget(),
                _buildRememberWidget(),
                if (!getBoolAsync("Yes")) _buildSocialWidget(),
                30.height,
              ],
            ),
          ),
        ));
  }
}

