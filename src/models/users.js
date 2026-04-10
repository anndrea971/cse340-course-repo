import db from './db.js';
import bcrypt from 'bcrypt';

const createUser = async (name, email, passwordHash) => {
    const query = `
        INSERT INTO users (name, email, password_hash, role_id) 
        VALUES ($1, $2, $3, (SELECT role_id FROM roles WHERE role_name = 'user')) 
        RETURNING user_id;`;
    const result = await db.query(query, [name, email, passwordHash]);
    return result.rows[0].user_id;
};

const findUserByEmail = async (email) => {
    const query = `
        SELECT u.user_id, u.name, u.email, u.password_hash, r.role_name 
        FROM users u 
        JOIN roles r ON u.role_id = r.role_id 
        WHERE u.email = $1;`;
    const result = await db.query(query, [email]);
    return result.rows.length > 0 ? result.rows[0] : null;
};

const authenticateUser = async (email, password) => {
    const user = await findUserByEmail(email);
    if (!user) return null;
    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (isMatch) {
        delete user.password_hash; // Don't send the hash to the session!
        return user;
    }
    return null;
};

// Required for Assignment: Get all users
const getAllUsers = async () => {
    const query = `
        SELECT u.name, u.email, r.role_name 
        FROM users u 
        JOIN roles r ON u.role_id = r.role_id 
        ORDER BY u.name;`;
    const result = await db.query(query);
    return result.rows;
};

export { createUser, findUserByEmail, authenticateUser, getAllUsers };