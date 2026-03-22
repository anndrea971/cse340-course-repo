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

const getProjectsByOrganizationId = async (organizationId) => {
      const query = `
        SELECT
          project_id,
          organization_id,
          title,
          description,
          location,
          date
        FROM project
        WHERE organization_id = $1
        ORDER BY date;
      `;
      
      const query_params = [organizationId];
      const result = await db.query(query, query_params);

      return result.rows;
};

export { getAllProjects, getProjectsByOrganizationId };