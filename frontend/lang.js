const translations = {
    en: {
        title: "SheStays – AI Risk Dashboard",
        total: "Total Students",
        risk: "Risk Distribution",
        district: "District Distribution",
        actionTitle: "Teacher Action Console",
        viewTitle: "Intervention History",

        lblName: "Student Name:",
        namePlaceholder: "Enter student name",
        lblDistrict: "District:",
        lblRisk: "Risk Level:",
        lblAction: "Action Taken:",
        lblRemarks: "Remarks:",
        lblStatus: "Status:",
        submitBtn: "Submit",

        navDashboard: "Dashboard",
        navAdd: "Add Intervention",
        navView: "View Interventions",

        // Table headers (interventions.html)
        thName: "Name",
        thDistrict: "District",
        thRisk: "Risk",
        thAction: "Action",
        thRemarks: "Remarks",
        thStatus: "Status",
        thDate: "Date",

        selectDefault: "-- Select --",
        districtPlaceholder: "-- Select District --",
        remarksPlaceholder: "-- Select Remarks --",

        riskHigh: "High", riskMedium: "Medium", riskLow: "Low",
        statusInProgress: "In Progress", statusCompleted: "Completed",

        distChennai: "Chennai", distCoimbatore: "Coimbatore", distMadurai: "Madurai",
        distTrichy: "Trichy", distSalem: "Salem", distErode: "Erode",
        distTirunelveli: "Tirunelveli", distThanjavur: "Thanjavur",
        distThoothukudi: "Thoothukudi", distVellore: "Vellore",

        actionCounselling: "Counselling", actionParentMeeting: "Parent Meeting",
        actionWarningNotice: "Warning Notice", actionMedicalHelp: "Medical Help",
        actionPoliceReport: "Police Report", actionTeacherGuidance: "Teacher Guidance",
        actionPsychologistReferral: "Psychologist Referral", actionCommunitySupport: "Community Support",
        actionSchoolTransfer: "School Transfer", actionNoActionNeeded: "No Action Needed",

        remarkParentContacted: "Parent contacted",
        remarkStudentCounselled: "Student counselled",
        remarkMedicalRequired: "Medical attention required",
        remarkUnderObservation: "Under observation",
        remarkIssueResolved: "Issue resolved",
        remarkReferredToAuthority: "Referred to authority",
        remarkFollowUpNeeded: "Follow up needed"
    },

    ta: {
        title: "ஷீசேஸ் – AI ஆபத்து முகப்பலகை",
        total: "மொத்த மாணவர்கள்",
        risk: "ஆபத்து பகிர்வு",
        district: "மாவட்ட விவரம்",
        actionTitle: "ஆசிரியர் செயல் பதிவேடு",
        viewTitle: "தலையீட்டு வரலாறு",

        lblName: "மாணவர் பெயர்:",
        namePlaceholder: "மாணவர் பெயரை உள்ளிடவும்",
        lblDistrict: "மாவட்டம்:",
        lblRisk: "ஆபத்து நிலை:",
        lblAction: "மேற்கொள்ளப்பட்ட நடவடிக்கை:",
        lblRemarks: "குறிப்புகள்:",
        lblStatus: "நிலை:",
        submitBtn: "சமர்ப்பி",

        navDashboard: "முகப்பலகை",
        navAdd: "தலையீட்டைச் சேர்",
        navView: "தலையீடுகளைக் காண்",

        // Table headers
        thName: "பெயர்",
        thDistrict: "மாவட்டம்",
        thRisk: "ஆபத்து நிலை",
        thAction: "நடவடிக்கை",
        thRemarks: "குறிப்புகள்",
        thStatus: "நிலை",
        thDate: "தேதி",

        selectDefault: "-- தேர்ந்தெடு --",
        districtPlaceholder: "-- மாவட்டத்தைத் தேர்ந்தெடு --",
        remarksPlaceholder: "-- குறிப்பைத் தேர்ந்தெடு --",

        riskHigh: "அதிகம்", riskMedium: "மிதமான", riskLow: "குறைவு",
        statusInProgress: "நடந்து கொண்டிருக்கிறது", statusCompleted: "முடிந்தது",

        distChennai: "சென்னை", distCoimbatore: "கோயம்புத்தூர்", distMadurai: "மதுரை",
        distTrichy: "திருச்சி", distSalem: "சேலம்", distErode: "ஈரோடு",
        distTirunelveli: "திருநெல்வேலி", distThanjavur: "தஞ்சாவூர்",
        distThoothukudi: "தூத்துக்குடி", distVellore: "வேலூர்",

        actionCounselling: "ஆலோசனை", actionParentMeeting: "பெற்றோர் சந்திப்பு",
        actionWarningNotice: "எச்சரிக்கை அறிவிப்பு", actionMedicalHelp: "மருத்துவ உதவி",
        actionPoliceReport: "காவல் அறிக்கை", actionTeacherGuidance: "ஆசிரியர் வழிகாட்டுதல்",
        actionPsychologistReferral: "உளவியலாளர் பரிந்துரை", actionCommunitySupport: "சமூக ஆதரவு",
        actionSchoolTransfer: "பள்ளி மாற்றம்", actionNoActionNeeded: "நடவடிக்கை தேவையில்லை",

        remarkParentContacted: "பெற்றோர் தொடர்பு கொள்ளப்பட்டது",
        remarkStudentCounselled: "மாணவர் ஆலோசனை செய்யப்பட்டார்",
        remarkMedicalRequired: "மருத்துவ கவனம் தேவை",
        remarkUnderObservation: "கண்காணிப்பில் உள்ளார்",
        remarkIssueResolved: "பிரச்சினை தீர்க்கப்பட்டது",
        remarkReferredToAuthority: "அதிகாரத்திற்கு பரிந்துரைக்கப்பட்டது",
        remarkFollowUpNeeded: "பின்தொடர்வு தேவை",
    }
};

function applyLanguage(lang) {
    const t = translations[lang] || translations.en;

    // Navbar (common)
    ['navDashboard', 'navAdd', 'navView'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.textContent = t[id];
    });

    // Dashboard (index.html)
    const dashboardTitle = document.querySelector('h1[data-lang="title"]') || document.getElementById('title');
    if (dashboardTitle) dashboardTitle.textContent = t.title;

    const totalLabel = document.querySelector('h3[data-lang="total"]') || document.getElementById('totalLabel');
    if (totalLabel) totalLabel.textContent = t.total;

    const riskLabel = document.querySelector('h3[data-lang="risk"]') || document.getElementById('riskLabel');
    if (riskLabel) riskLabel.textContent = t.risk;

    const districtLabel = document.querySelector('h3[data-lang="district"]') || document.getElementById('districtLabel');
    if (districtLabel) districtLabel.textContent = t.district;

    // Action page
    const actionTitle = document.getElementById('actionTitle');
    if (actionTitle) actionTitle.textContent = t.actionTitle;

    const nameLabel = document.getElementById('lblName');
    if (nameLabel) {
        nameLabel.textContent = t.lblName;
        document.getElementById('name').placeholder = t.namePlaceholder;
    }

    ['lblDistrict', 'lblRisk', 'lblAction', 'lblRemarks', 'lblStatus', 'submitBtn'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.textContent = t[id];
    });

    // Interventions page
    const viewTitle = document.getElementById('viewTitle');
    if (viewTitle) viewTitle.textContent = t.viewTitle;

    ['thName', 'thDistrict', 'thRisk', 'thAction', 'thRemarks', 'thStatus', 'thDate'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.textContent = t[id];
    });

    // Dropdowns
    translateSelect("district", t.districtPlaceholder, [
        "distChennai", "distCoimbatore", "distMadurai", "distTrichy", "distSalem",
        "distErode", "distTirunelveli", "distThanjavur", "distThoothukudi", "distVellore"
    ], t);

    translateSelect("risk", t.selectDefault, ["riskHigh", "riskMedium", "riskLow"], t);
    translateSelect("action", t.selectDefault, [
        "actionCounselling", "actionParentMeeting", "actionWarningNotice", "actionMedicalHelp",
        "actionPoliceReport", "actionTeacherGuidance", "actionPsychologistReferral",
        "actionCommunitySupport", "actionSchoolTransfer", "actionNoActionNeeded"
    ], t);
    translateSelect("remarks", t.remarksPlaceholder, [
        "remarkParentContacted", "remarkStudentCounselled", "remarkMedicalRequired",
        "remarkUnderObservation", "remarkIssueResolved", "remarkReferredToAuthority",
        "remarkFollowUpNeeded"
    ], t);
    translateSelect("status", t.selectDefault, ["statusInProgress", "statusCompleted"], t);
}

function translateSelect(id, placeholder, keys, t) {
    const sel = document.getElementById(id);
    if (!sel) return;
    sel.options[0].text = placeholder;
    keys.forEach((key, i) => {
        const idx = i + 1;
        if (sel.options[idx]) sel.options[idx].text = t[key];
    });
}

function changeLang(lang) {
    localStorage.setItem("lang", lang);
    applyLanguage(lang);
    document.querySelectorAll('input[name="lang"]').forEach(r => {
        r.checked = (r.value === lang);
    });
}

function initLanguage() {
    let lang = localStorage.getItem("lang") || "en";
    applyLanguage(lang);
    document.querySelectorAll('input[name="lang"]').forEach(r => {
        r.checked = (r.value === lang);
    });
}

window.changeLang = changeLang;
window.initLanguage = initLanguage;