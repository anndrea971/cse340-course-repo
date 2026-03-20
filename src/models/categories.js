import db from './db.js';

const getAllCategories = async () => {
  try {
    const sql = `SELECT * FROM public.category ORDER BY name ASC`;
    const data = await db.query(sql);
    return data.rows;
  } catch (error) {
    console.error("getAllCategories error: " + error);
    throw error;
  }
}

export {getAllCategories};