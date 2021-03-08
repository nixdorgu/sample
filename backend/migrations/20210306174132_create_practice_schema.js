
exports.up = function(knex) {
  return knex.raw('CREATE SCHEMA practice');
};

exports.down = function(knex) {
    return knex.raw('DROP SCHEMA practice');
  
};
