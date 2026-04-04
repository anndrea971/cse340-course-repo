import { body, validationResult} from 'express-validator';
import { createCategory, updateCategory, getAllCategories, getCategoryById, getProjectsByCategoryId, getCategoriesByProjectId, updateCategoryAssignments } from '../models/categories.js';
import { getProjectDetails } from '../models/projects.js';

// Define any controller functions
const showCategoriesPage = async (req, res) => {
  const categories = await getAllCategories();
  const title = 'Service Categories';

  res.render('categories', { title, categories });
};

const showCategoryDetailsPage = async (req, res, next) => {
  const categoryId = req.params.id;
  const category = await getCategoryById(categoryId);

  if (!category) {
    const error = new Error('Category not found');
    error.status = 404;
    return next(error);
  }

  const projects = await getProjectsByCategoryId(categoryId);

  res.render('category', { title: category.name, categoryName: category.name, category, projects });
};

const showAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;
    const project = await getProjectDetails(projectId);
    const categories = await getAllCategories();
    const assignedCategories = await getCategoriesByProjectId(projectId);
    const title = 'Assign Categories to Project';

    res.render('assign-categories', { title, project, categories, assignedCategories });
};

const processAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;
    const categoryIds = req.body.categoryIds || [];

    await updateCategoryAssignments(projectId, categoryIds);

    req.flash('success', 'Categories updated successfully!');

    res.redirect(`/project/${projectId}`);
};

const categoryValidation = [
  body('name')
    .trim()
    .notEmpty().withMessage('Category name is required')
    .isLength({ min: 3, max: 100 }).withMessage('Category name must be between 3 and 100 characters')
];

const showNewCategoryForm = async (req, res) => {
  res.render('new-category', { title: 'Add New Category' });
};

const processNewCategoryForm = async (req, res) => {
  const results = validationResult(req);
  if (!results.isEmpty()) {
    results.array().forEach((error) => {
      req.flash('error', error.msg);
    });
    return res.redirect('/new-category');
  }
  const { name, description } = req.body;
  await createCategory(name, description);
  req.flash('success', 'Category created successfully!');
  res.redirect('/categories');
};

const showEditCategoryForm = async (req, res) => {
  const categoryId = req.params.id;
  const category = await getCategoryById(categoryId);
  res.render('edit-category', { title: 'Edit Category', category });
};

const processEditCategoryForm = async (req, res) => {
  const categoryId = req.params.id;
  const results = validationResult(req);
  if (!results.isEmpty()) {
    results.array().forEach((error) => {
      req.flash('error', error.msg);
    });
    return res.redirect(`/edit-category/${categoryId}`);
  }
  const { name, description } = req.body;
  await updateCategory(categoryId, name, description);
  req.flash('success', 'Category updated successfully!');
  res.redirect(`/category/${categoryId}`);
};

// Export any controller functions
export { showCategoriesPage, showCategoryDetailsPage, showAssignCategoriesForm, processAssignCategoriesForm, showNewCategoryForm, processNewCategoryForm, categoryValidation, showEditCategoryForm, processEditcategoryForm}; };
