import { addVolunteer, removeVolunteer } from '../models/volunteers.js';

const processAddVolunteer = async (req, res) => {
    const projectId = req.params.id;
    const userId = req.session.user.user_id;
    try {
        await addVolunteer(userId, projectId);
        req.flash('success', 'You have successfully volunteered for this project!');
    } catch (error) {
        req.flash('error', 'You are already volunteering or an error occurred.');
    }
    res.redirect(`/project/${projectId}`);
};

const processRemoveVolunteer = async (req, res) => {
    const projectId = req.params.id;
    const userId = req.session.user.user_id;
    try {
        await removeVolunteer(userId, projectId);
        req.flash('success', 'You are no longer volunteering for this project.');
    } catch (error) {
        req.flash('error', 'Error removing volunteer status.');
    }
    
    // Redirect back to dashboard if they clicked remove from the dashboard
    const referer = req.get('Referrer');
    if (referer && referer.includes('/dashboard')) {
        res.redirect('/dashboard');
    } else {
        res.redirect(`/project/${projectId}`);
    }
};

export { processAddVolunteer, processRemoveVolunteer };