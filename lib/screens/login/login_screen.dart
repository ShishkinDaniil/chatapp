import 'package:chatapp/blocs/auth/auth_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _pageSwitchDuration = Duration(milliseconds: 100);
  static const _validateDuration = Duration(milliseconds: 300);

  late PageController _pageViewController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _surnameFocus = FocusNode();

  final GlobalKey<FormState> _signInKey = GlobalKey();
  final GlobalKey<FormState> _signUpKey = GlobalKey();
  bool get _hasAnyFocus =>
      _passFocus.hasFocus || _emailFocus.hasFocus || _nameFocus.hasFocus;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final bodies = [_buildSignInBody(), _buildSignUpBody()];

    return Scaffold(
      appBar: null,
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageViewController,
        itemCount: bodies.length,
        itemBuilder: (context, index) {
          return _buildBody(bodies[index], index);
        },
      ),
    );
  }

  Widget _buildBody(List<Widget> signBody, int index) {
    return Form(
      key: index == 0 ? _signInKey : _signUpKey,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            const Spacer(),
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: signBody,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSignInBody() {
    return [
      const Text('Вход'),
      TextFormField(
        onTap: _signInValidate,
        focusNode: _emailFocus,
        onTapOutside: (event) {
          _emailFocus.unfocus();
          _signInValidate();
        },
        controller: _emailController,
        decoration: const InputDecoration(hintText: 'Email'),
        validator: _validateEmail,
        onEditingComplete: _signInValidate,
      ),
      TextFormField(
        onTap: _signInValidate,
        focusNode: _passFocus,
        controller: _passwordController,
        decoration: const InputDecoration(hintText: 'Пароль'),
        validator: _validatePassword,
        obscureText: true,
        onTapOutside: (event) {
          _passFocus.unfocus();
          _signInValidate();
        },
        onEditingComplete: _signInValidate,
      ),
      ElevatedButton(
        onPressed: () {
          final valid = _signInKey.currentState?.validate();
          if (valid == true) {
            _onTapToSignIn(context.authBloc);
          }
        },
        child: const Text('Войти'),
      ),
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          const Text('Eщё не зарегестрированы?'),
          TextButton(
            onPressed: () {
              _passwordController.text = '';
              _pageViewController.nextPage(
                duration: _pageSwitchDuration,
                curve: Curves.ease,
              );
            },
            child: const Text('Зарегестрироваться'),
          )
        ],
      )
    ];
  }

  List<Widget> _buildSignUpBody() {
    return [
      const Text('Регистрация'),
      TextFormField(
        onTap: _signUpValidate,
        controller: _nameController,
        decoration: const InputDecoration(hintText: 'Имя'),
        validator: _validateName,
        focusNode: _nameFocus,
        onTapOutside: (event) {
          _nameFocus.unfocus();
          _signUpValidate();
        },
        onEditingComplete: _signUpValidate,
      ),
      TextFormField(
        onTap: _signUpValidate,
        controller: _surnameController,
        decoration: const InputDecoration(hintText: 'Фамилия'),
        validator: _validateName,
        focusNode: _surnameFocus,
        onTapOutside: (event) {
          _surnameFocus.unfocus();
          _signUpValidate();
        },
        onEditingComplete: _signUpValidate,
      ),
      TextFormField(
        onTap: _signUpValidate,
        focusNode: _emailFocus,
        onTapOutside: (event) {
          _emailFocus.unfocus();
          _signUpValidate();
        },
        controller: _emailController,
        decoration: const InputDecoration(hintText: 'Email'),
        validator: _validateEmail,
        onEditingComplete: _signUpValidate,
      ),
      TextFormField(
        onTap: _signUpValidate,
        focusNode: _passFocus,
        controller: _passwordController,
        decoration: const InputDecoration(hintText: 'Пароль'),
        validator: _validatePassword,
        obscureText: true,
        onTapOutside: (event) {
          _passFocus.unfocus();
          _signUpValidate();
        },
        onEditingComplete: _signUpValidate,
      ),
      ElevatedButton(
          onPressed: () {
            if (_signUpKey.currentState?.validate() == true) {
              _onTapToSignUp(context.authBloc);
            }
          },
          child: const Text('Sign Up')),
      TextButton(
        onPressed: () {
          _passwordController.text = '';
          _pageViewController.previousPage(
            duration: _pageSwitchDuration,
            curve: Curves.ease,
          );
        },
        child: const Text('Назад'),
      )
    ];
  }

  void _onTapToSignIn(AuthBloc authBloc) => authBloc.add(
        AuthLogin(_emailController.text, _passwordController.text),
      );

  void _onTapToSignUp(AuthBloc authBloc) => authBloc.add(
        AuthRegistration(_emailController.text, _passwordController.text,
            _nameController.text, _surnameController.text),
      );

  void _signInValidate() {
    Future.delayed(
      _validateDuration,
      () => _signInKey.currentState?.validate(),
    );
  }

  void _signUpValidate() {
    Future.delayed(
      _validateDuration,
      () => _signUpKey.currentState?.validate(),
    );
  }

  String? _validateEmail(String? value) {
    if (!_hasAnyFocus) {
      if (value == null || value.isEmpty) {
        return "Email is empty";
      }

      if (!EmailValidator.validate(value)) {
        return "Email invalid";
      }

      return null;
    }
    return null;
  }

  String? _validateName(String? value) {
    if (!_hasAnyFocus) {
      if (value == null || value.isEmpty) {
        return "Name is empty";
      }

      return null;
    }
    return null;
  }

  String? _validatePassword(
    String? value,
  ) {
    if (!_hasAnyFocus) {
      if (_emailController.text.isNotEmpty) {
        if (value == null ||
            value.isEmpty && _emailController.text.isNotEmpty) {
          return "Pass empty";
        }

        if (!RegExp(r'^[A-Za-z\d*;%)(_\]\[.,#@!$&^+=-]{6,20}$')
            .hasMatch(value)) {
          return "Pass incorrect";
        }
      }
      return null;
    }
    return null;
  }
}
