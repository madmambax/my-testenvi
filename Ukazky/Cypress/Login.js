var cas = 3000;
var prihlas = ['testujeme3@gmail.com', 'exportdat', 'TT'];


it('ID C22', () => {
    cy.visit('https://www.rohlik.cz/')
// Pozitivní přihlášení
    cy.get('#headerLogin').click() //1. Klik: Přihlásit
    cy.wait(cas)
    cy.get('input[name="email"]').type(prihlas[0]).should('have.value',prihlas[0]) //2. Doplnit platný email
    cy.get('input[name="password"]').type(prihlas[1]) //3. Doplnit platné heslo
    cy.wait(cas)
    cy.get('[data-test="btnSignIn"]').click() //4. Přihlásit se
    cy.wait(cas)
    cy.get('.sc-18g3ccf-6').should('have.text', prihlas[2])  // V pravém horním rohu se objeví kolečko a v něm TT
})
