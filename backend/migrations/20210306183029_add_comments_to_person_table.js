exports.up = function (knex) {
  return knex.raw(`
    COMMENT ON TABLE practice.person IS 'A user of this practice app';
    COMMENT ON COLUMN practice.person.id IS 'The primary unique identifier for the person';
    COMMENT ON COLUMN practice.person.first_name IS 'The first name of the person.';
    COMMENT ON COLUMN practice.person.last_name IS 'The last name of the person.';
    COMMENT ON COLUMN practice.person.created_at IS 'The time this user was created.';
  `);
};

exports.down = function (knex) {
  return knex.raw(`
    COMMENT ON TABLE practice.person IS NULL;
    COMMENT ON COLUMN practice.person.id IS NULL;
    COMMENT ON COLUMN practice.person.first_name IS NULL;
    COMMENT ON COLUMN practice.person.last_name IS NULL;
    COMMENT ON COLUMN practice.person.created_at IS NULL;
  `);
};
