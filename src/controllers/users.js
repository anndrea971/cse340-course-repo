import bcrypt from 'bcrypt';
import { createUser, authenticateUser, getAllUsers } from '../models/users.js';

// --- MIDDLEWARE ---
const requireLogin = (req, res, next) => {
    if (!req.session || !req.session.user) {
        req.flash('error', 'You must be logged in to access this page.');
        return res.redirect('/login');
    }
    next();
};

const requireRole = (role) => {
    return (req, res, next) => {
        if (!req.session || !req.session.user) {
            req.flash('error', 'Please log in first.');
            return res.redirect('/login');
        }
        if (req.session.user.role_name !== role) {
            req.flash('error', 'You do not have permission to view this page.');
            return res.redirect('/dashboard');
        }
        next();
    };
};

// --- CONTROLLERS ---
const showUserRegistrationForm = (req, res) => res.render('register', { title: 'Register' });

const processUserRegistrationForm = async (req, res) => {
    const { name, email, password } = req.body;
    try {
        const passwordHash = await bcrypt.hash(password, 10);
        await createUser(name, email, passwordHash);
        req.flash('success', 'Registration successful! Please log in.');
        res.redirect('/login');
    } catch (error) {
        req.flash('error', 'Error during registration. Email may already exist.');
        res.redirect('/register');
    }
};

const showLoginForm = (req, res) => res.render('login', { title: 'Login' });

const processLoginForm = async (req, res) => {
    const { email, password } = req.body;
    const user = await authenticateUser(email, password);
    if (user) {
        req.session.user = user;
        req.flash('success', 'Login successful!');
        res.redirect('/dashboard');
    } else {
        req.flash('error', 'Invalid email or password.');
        res.redirect('/login');
    }
};

const processLogout = (req, res) => {
    req.session.destroy();
    res.redirect('/login');
};

const showDashboard = (req, res) => {
    res.render('dashboard', { title: 'Dashboard', user: req.session.user });
};

const showUsersPage = async (req, res) => {
    const usersList = await getAllUsers();
    res.render('users', { title: 'All Registered Users', usersList });
};

export { 
    requireLogin, requireRole, 
    showUserRegistrationForm, processUserRegistrationForm, 
    showLoginForm, processLoginForm, processLogout, 
    showDashboard, showUsersPage 
};