// src/controllers/categories.js
import { getCategories, getCategoryDetails } from '../models/categories.js';

export const showCategoriesPage = async (req, res, next) => {
    try {
        const categories = await getCategories();
        // IMPORTANTE: Pasamos la variable 'categories' a la vista categories.ejs
        res.render('categories', { title: 'All Categories', categories });
    } catch (error) {
        next(error);
    }
};

export const showCategoryDetailsPage = async (req, res, next) => {
    try {
        const id = req.params.id;
        const data = await getCategoryDetails(id);

        if (!data.name) {
            return res.status(404).render('errors/404', { title: 'Category Not Found' });
        }

        // IMPORTANTE: Pasamos 'categoryName' y 'projects' a la vista category.ejs
        res.render('category', { 
            title: `Category: ${data.name}`, 
            categoryName: data.name, 
            projects: data.projects 
        });
    } catch (error) {
        next(error);
    }
};