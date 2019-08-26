const router = require('express').Router();

// const User = require("../models/User");

const passport = require('passport');

router.get('/users/signin', (req,res)=>{
    res.render('users/signin')
});

router.post('/users/signin', passport.authenticate('local', {
    successRedirect: '/',
    failureRedirect: '/users/signin',
    failureFlash: true
}));

router.get('/users/signup', (req,res)=>{
    res.render('users/signup')
});

router.post('/users/signup', async (req,res)=>{
    const {name, lastname, mail, phone, password, confirm_password, healphInsurance} = req.body;
    const errors = [];
    const health = 'Obra Social o Prepaga';
    if(password!= confirm_password){
        errors.push({text: 'Las contraseñas deben ser iguales'});
    }
    if(password.length < 8){
        errors.push({text: 'La contraseña debe tener mas de 8 digitos'})
    }
    if(healphInsurance==health){
        errors.push({text: 'Seleccione alguna obra social'});
    }
    if(errors.length > 0){
        res.render('users/signup', {errors, name, lastname, mail, phone, password, confirm_password, healphInsurance});
    }else{
        // Ask DB if user exist and return an user
        // const mailUser = await User.findOne({mail: mail});
        // if(mailUser){
        //     req.flash('error_msg', 'El mail ya fue usado');
        //     res.redirect('/users/signup');
        // }
        // const newUser = new User({name, lastname, mail, phone, password});
        // newUser.password = await newUser.encryptPassword(password);
        // // Save user on DB
        // await newUser.save();
        req.flash('success_msg', 'Registrado Correctamente');
        res.redirect('/users/signin');
    }
});

router.get('/users/logout', (req,res)=>{
    req.logout();
    res.redirect('/');
});

module.exports = router;