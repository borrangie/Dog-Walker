const passport = require('passport');
const localStrategy = require('passport-local').Strategy;

const User = require('../models/User');

passport.use(new localStrategy({
    usernameField: 'mail'
}, async (mail, password, done)=>{
    const user = await User.findOne({mail: mail});
    if(!user){
        return done(null, false, {message: 'Usuario no encontrado '});
    }else{
        const match = await user.matchPassword(password);
        if(match){
            return done(null, user);
        }else{
            return done(null, false, {message: 'Contraseña Incorrecta'});
        }
    }
}));

passport.serializeUser((user, done)=>{
    done(null, user.id);
});

passport.deserializeUser((id, done)=>{
    User.findById(id, (err, user)=>{
        done(err, user);
    });
});