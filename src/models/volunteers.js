import db from './db.js';

const addVolunteer = async (userId, projectId) => {
    const query = `INSERT INTO volunteer (user_id, project_id) VALUES ($1, $2)`;
    await db.query(query, [userId, projectId]);
};

const removeVolunteer = async (userId, projectId) => {
    const query = `DELETE FROM volunteer WHERE user_id = $1 AND project_id = $2`;
    await db.query(query, [userId, projectId]);
};

const checkVolunteerStatus = async (userId, projectId) => {
    const query = `SELECT * FROM volunteer WHERE user_id = $1 AND project_id = $2`;
    const result = await db.query(query, [userId, projectId]);
    return result.rows.length > 0;
};

const getVolunteeredProjects = async (userId) => {
    const query = `
        SELECT p.project_id, p.title, p.start_date, o.name AS organization_name
        FROM project p
        JOIN volunteer v ON p.project_id = v.project_id
        JOIN organization o ON p.organization_id = o.organization_id
        WHERE v.user_id = $1
        ORDER BY p.start_date ASC;
    `;
    const result = await db.query(query, [userId]);
    return result.rows;
};

export { addVolunteer, removeVolunteer, checkVolunteerStatus, getVolunteeredProjects };