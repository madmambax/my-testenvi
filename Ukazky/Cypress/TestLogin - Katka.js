it('login correct', () => {
    cy.visit('http://testovani.kitner.cz/login_app/index.php')
    cy.get('#inputUsername').type('novak')
    cy.get('#inputPassword').type('tajnenovak{enter}')
    cy.url().should('include', 'welcome.php')
})