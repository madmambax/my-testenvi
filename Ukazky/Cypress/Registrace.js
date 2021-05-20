var cas = 3000;
var regis = ['John Tester', 'test20g@gmail.com','exportdat', '777403666','Ostrava', '79000' ];

it('ID C21', () => {
    cy.visit('https://www.rohlik.cz/')
// Pozitivní registrace
    cy.get('#headerLogin').click() //1. Klik: Přihlásit
    cy.get('[data-test="linkRegistration"]').click() //2. Klik: Registrace
    cy.wait(cas)
    cy.get('input[name="name"]').type(regis[0]).should('have.value', regis[0]) //3. Doplnit platné jméno a příjmení
    cy.get('input[name="email"]').type(regis[1]).should('have.value', regis[1]) //4. Doplnit platný email
    cy.get('input[name="password"]').type(regis[2]) //5. Doplnit platné heslo
    cy.get('input[name="phoneNumber"]').type(regis[3]).should('have.value', regis[3]) //6. Doplnit platné tel.číslo
    cy.get('input[name="city"]').type(regis[4]).should('have.value', regis[4]) //7. Doplnit platné bydliště
    cy.get('input[name="postalCode"]').type(regis[5]).should('have.value', regis[5]) //8. Doplnit platné PSC
    cy.wait(cas)
    cy.get('.aztc4u-0').click() //9. Zaškrtnout: Souhlasím se zásadami zpracování osobních údajů
    cy.get('[data-test="btnContinueRegistration"]').click() //10. Klik: Pokračovat
    cy.contains("Výborně!").end() // Vyskočí hláška: Výborně!
    })