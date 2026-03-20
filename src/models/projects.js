import db from './db.js';

const getAllProjects = async () => {
  try {
    const sql = `SELECT p.*, o.name AS organization_name 
                 FROM public.projects p 
                 JOIN public.organization o 
                 ON p.organization_id = o.organization_id 
                 ORDER BY p.project_date ASC`;
    const data = await db.query(sql);
    return data.rows;
  } catch (error) {
    console.error("getAllProjects error: " + error);
    throw error;
  }
}

export {getAllProjects};
