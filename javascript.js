const combinedCode = document.getElementById('combined-code');
        const htmlPreview = document.getElementById('html-preview');
        const updateButton = document.getElementById('update-button');
        const verification = document.getElementById('verification');

        updateButton.addEventListener('click', updatePreview);

        function updatePreview() {
            const codeContent = combinedCode.value;

            htmlPreview.srcdoc = codeContent;
        }