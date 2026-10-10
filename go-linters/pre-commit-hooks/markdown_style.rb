################################################################################
# Style file for markdownlint.
#
# https://github.com/markdownlint/markdownlint/blob/master/docs/configuration.md
#
# This file is referenced by the project file `.mdlrc`.
################################################################################

#===============================================================================
# Start with all built-in rules.
# https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md
all

#===============================================================================
# Override default parameters for some built-in rules.
# https://github.com/markdownlint/markdownlint/blob/master/docs/creating_styles.md#parameters

# Ignore line length in tables and code blocks.
rule 'MD013', :tables => false
rule 'MD013', :code_blocks => false

#===============================================================================
# Exclude the rules that do not apply.

# Multiple headers with the same content: Changelog/release notes or other such
# files might have same sections
exclude_rule 'MD024'

# Ordered list item prefix: pre-existing formatting
exclude_rule 'MD029'
