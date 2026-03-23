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

const getProjectsByOrganizationId = async (organizationId) => {
    // Usamos AS date para que tu EJS no se rompa si busca .date
    const query = `
      SELECT
        project_id,
        organization_id,
        title,
        description,
        location,
        project_date AS date 
      FROM public.projects
      WHERE organization_id = $1
      ORDER BY project_date ASC;
    `;
    
    const query_params = [organizationId];
    const result = await db.query(query, query_params);
    return result.rows;
};

const getUpcomingProjects = async (number_of_projects) => {
  const sql = `
    SELECT p.*, o.name AS organization_name 
    FROM public.projects p 
    JOIN public.organization o ON p.organization_id = o.organization_id 
    WHERE p.project_date >= CURRENT_DATE 
    ORDER BY p.project_date ASC 
    LIMIT $1`;
  const result = await db.query(sql, [number_of_projects]);
  return result.rows;
};

/**
 * getProjectDetails con soporte para categorías (Interconexión)
 */
const getProjectDetails = async (id) => {
  const sql = `
    SELECT 
      p.project_id, 
      p.title, 
      p.description, 
      p.project_date, 
      p.location, 
      p.organization_id, 
      o.name AS organization_name
    FROM public.projects p
    JOIN public.organization o ON p.organization_id = o.organization_id
    WHERE p.project_id = $1;
  `;
  const result = await db.query(sql, [id]);
  return result.rows[0];
};

export { getAllProjects, getProjectsByOrganizationId, getUpcomingProjects, getProjectDetails };