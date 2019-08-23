const router = require('express').Router();

router.get('/users/signin', (req,res)=>{
    res.render('users/signin')
});

router.get('/users/signup', (req,res)=>{
    res.render('users/signup')
});

router.post('/users/signup', (req,res)=>{
    console.log(req.body);
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
        res.send('ok');
    }
});

module.exports = router;