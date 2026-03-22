import db from './db.js';

// --- Part 1: Get all (You likely already have this) ---
const getAllOrganizations = async () => {
    const query = `
        SELECT organization_id, name, description, contact_email, logo_filename
        FROM public.organization;
    `;
    const result = await db.query(query);
    return result.rows;
};

// --- Part 2: Get details (This is what the error is complaining about!) ---
const getOrganizationDetails = async (organizationId) => {
    const query = `
        SELECT organization_id, name, description, contact_email, logo_filename
        FROM public.organization 
        WHERE organization_id = $1;
    `;
    const result = await db.query(query, [organizationId]);
    return result.rows[0]; // Return just the one organization
};

// --- Part 3: The Export (Must include BOTH names) ---
export { getAllOrganizations, getOrganizationDetails };