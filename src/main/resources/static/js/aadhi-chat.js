/**
 * TALK TO AADHI - FLOATING CHATBOT CONTROLLER
 * Rule-driven, database-connected AI transport assistant
 */

document.addEventListener('DOMContentLoaded', function () {
    const chatBtn = document.getElementById('aadhiChatToggle');
    const chatBox = document.getElementById('aadhiChatBox');
    const closeBtn = document.getElementById('aadhiChatClose');
    const sendBtn = document.getElementById('aadhiSendBtn');
    const inputField = document.getElementById('aadhiInputField');
    const msgContainer = document.getElementById('aadhiMessages');

    if (!chatBtn || !chatBox) return;

    // Toggle Chat Window
    chatBtn.addEventListener('click', function () {
        if (chatBox.style.display === 'flex') {
            chatBox.style.display = 'none';
        } else {
            chatBox.style.display = 'flex';
            if (inputField) inputField.focus();
            scrollToBottom();
        }
    });

    if (closeBtn) {
        closeBtn.addEventListener('click', function () {
            chatBox.style.display = 'none';
        });
    }

    // Send Message on Enter
    if (inputField) {
        inputField.addEventListener('keydown', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                sendMessage();
            }
        });
    }

    if (sendBtn) {
        sendBtn.addEventListener('click', function () {
            sendMessage();
        });
    }

    function scrollToBottom() {
        if (msgContainer) {
            msgContainer.scrollTop = msgContainer.scrollHeight;
        }
    }

    function appendUserMessage(text) {
        const msgDiv = document.createElement('div');
        msgDiv.className = 'aadhi-msg user';
        msgDiv.textContent = text;
        msgContainer.appendChild(msgDiv);
        scrollToBottom();
    }

    function appendBotMessage(data) {
        const msgDiv = document.createElement('div');
        msgDiv.className = 'aadhi-msg bot';

        // Message text
        const textSpan = document.createElement('div');
        textSpan.style.whiteSpace = 'pre-line';
        textSpan.textContent = data.reply || data;
        msgDiv.appendChild(textSpan);

        // Action Button Link if provided
        if (data.actionLink && data.actionLabel) {
            const linkBtn = document.createElement('a');
            linkBtn.href = data.actionLink;
            linkBtn.className = 'btn btn-sm btn-outline-primary mt-2 rounded-pill d-inline-flex align-items-center gap-1';
            linkBtn.innerHTML = `<i class="fas fa-external-link-alt small"></i> ${data.actionLabel}`;
            msgDiv.appendChild(linkBtn);
        }

        // Suggestions chips
        if (data.suggestions && data.suggestions.length > 0) {
            const chipsContainer = document.createElement('div');
            chipsContainer.className = 'aadhi-chips-container';

            data.suggestions.forEach(function (chipText) {
                const chip = document.createElement('span');
                chip.className = 'aadhi-chip';
                chip.textContent = chipText;
                chip.addEventListener('click', function () {
                    if (inputField) inputField.value = chipText;
                    sendMessage();
                });
                chipsContainer.appendChild(chip);
            });

            msgDiv.appendChild(chipsContainer);
        }

        msgContainer.appendChild(msgDiv);
        scrollToBottom();
    }

    function showTypingIndicator() {
        const indicator = document.createElement('div');
        indicator.id = 'aadhiTypingIndicator';
        indicator.className = 'aadhi-msg bot text-muted fst-italic';
        indicator.innerHTML = '<i class="fas fa-circle-notch fa-spin me-1"></i> Aadhi is checking CollegeBusDB...';
        msgContainer.appendChild(indicator);
        scrollToBottom();
    }

    function removeTypingIndicator() {
        const ind = document.getElementById('aadhiTypingIndicator');
        if (ind) ind.remove();
    }

    function sendMessage() {
        const query = inputField.value.trim();
        if (!query) return;

        appendUserMessage(query);
        inputField.value = '';
        showTypingIndicator();

        // Get CSRF Token if present
        let headers = {
            'Content-Type': 'application/json'
        };
        const csrfTokenMeta = document.querySelector('meta[name="_csrf"]');
        const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
        if (csrfTokenMeta && csrfHeaderMeta) {
            headers[csrfHeaderMeta.getAttribute('content')] = csrfTokenMeta.getAttribute('content');
        }

        fetch('/api/chatbot/message', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify({ message: query })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network error: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            removeTypingIndicator();
            appendBotMessage(data);
        })
        .catch(err => {
            removeTypingIndicator();
            appendBotMessage({
                reply: "Sorry, I encountered a temporary connection issue. Please make sure the backend server is running.",
                suggestions: ["Find bus to Pallavaram", "Check available seats", "List all routes"],
                actionLink: "/find-bus",
                actionLabel: "Search Buses"
            });
        });
    }

    // Attach click listeners to default chips in DOM
    document.querySelectorAll('.aadhi-chip').forEach(function (chip) {
        chip.addEventListener('click', function () {
            if (inputField) inputField.value = chip.textContent;
            sendMessage();
        });
    });
});
