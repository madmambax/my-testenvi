ar cas = 3000;

it('Kontrola součtu ceny v košíku', () => {
    cy.visit('https://www.rohlik.cz/')
// Nákup
    cy.get('.sc-15s7ddf-3').click()
    cy.get('[href="/c300104000-uzeniny-a-lahudky"]').click() 
    cy.wait(4000)
    cy.get('[href="/c300104049-hotova-jidla-a-prilohy"]').click() 
    cy.wait(4000)
    cy.get(':nth-child(1) > .category_link > :nth-child(1)').click() 
    cy.wait(1000)
    cy.get('[href="/c300117179-tradicni"]').click() 
    cy.wait(4000)
    cy.get('[data-product-id="1374831"]').click() 
    cy.get('.sc-1tiied5-3').click().click() 
// Ověření přidání položky do košíku
    cy.get('.sc-1tiied5-4').should('have.value','3')
    cy.get('[data-product-id="1374859"]').click()
    cy.get('#product_1374859 > .amountCounterWrap > .sc-1tiied5-1 > .sc-1tiied5-3').click()
    cy.get('#product_1374859 > .amountCounterWrap > .sc-1tiied5-1 > .sc-1tiied5-4').should('have.value','2')
    cy.wait(3000)
    cy.get('.sc-1bqnk2m-1').click()
// Kontrola součtu ceny v košíku
    cy.get('[data-test="headerPrice"]').contains("600")
 cy.wait(cas)
// Odebrání všech kusu z košíku
    cy.get(':nth-child(2) > .mnzqp1-7 > .sc-1tiied5-1 > [data-test=btnMinus]').click().click()
    cy.get(':nth-child(3) > .mnzqp1-7 > .sc-1tiied5-1 > [data-test=btnMinus]').click().click().click()
    cy.wait(cas)
    cy.get('[data-test="headerPrice"]').contains("0")
})