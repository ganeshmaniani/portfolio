const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

// Configure Nodemailer with your email service (e.g., Gmail)
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'sudalaiganesh05@gmail.com', // Replace with your email
        pass: 'bems gpsx dlfx xftz', // Replace with your app password
    },
});

exports.sendEmail = functions.firestore
    .document('contact_form/{formId}')
    .onCreate(async (snap, context) => {
        const formData = snap.data();

        const mailOptions = {
            from: 'sudalaiganesh05@gmail.com', // Replace with your email
            to: 'sudalaiganesh05@gmail.com', // Replace with the recipient's email
            subject: `New Contact Form Submission: ${formData.subject}`,
            text: `
        Name: ${formData.name}
        Email: ${formData.email}
        Message: ${formData.message}
      `,
        };

        try {
            await transporter.sendMail(mailOptions);
            console.log('Email sent successfully');
        } catch (error) {
            console.error('Error sending email:', error);
        }
    });